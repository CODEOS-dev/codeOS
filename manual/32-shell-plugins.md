# Shell 插件

codeOS 桌面作为一个长期运行的 Quickshell 进程 `omarchy-shell` 运行，屏幕上几乎所有东西都是它内部的插件。顶栏是插件。顶栏下拉面板也是。全屏覆盖层比如 emoji 选择器和剪贴板管理器是。codeOS 菜单本身是。锁屏是。polkit 对话框是。还有那些没有 UI 的后台服务——监控电量、夜间暖屏——也是。

这不是一个实现细节。意味着你可以关掉桌面的某些部分、换掉它们、或写自己的，而不用改 codeOS 一行源码。

第一方插件由 codeOS 自带，放在 `$OMARCHY_PATH/shell/plugins/`。你自己加的——不管是自己做的实验还是 GitHub 上找的——放在 `~/.config/omarchy/plugins/`。启动时两者的发现机制相同，但内置插件享有受信任的 shell 接口，第三方插件只有限于自身服务和生命周期的受限接口。内置插件的克隆版本只保留原有行为所需的源码特定配置和 UI 调用。

## 查看已安装的

```
omarchy plugin list
```

会打印每个发现到的插件及其 id、是否启用、第一方还是第三方、类型、显示名。加 `--json` 可以喂给其他程序。

插件 id 有命名空间。内置的都以 `omarchy.` 开头——`omarchy.clock`、`omarchy.network`、`omarchy.notifications`——这个命名空间保留，第三方插件永远不能占用。

## 启用和禁用

```
omarchy plugin enable omarchy.tailscale
omarchy plugin disable omarchy.weather
```

或者用菜单：_Setup > Plugins_ 有 Enable、Disable、Add、Clone 和 Remove 选项，每个都有选择器只列出适合该操作的插件。

启用状态存在 `~/.config/omarchy/shell.json` 里，两种插件的规则略有不同。第三方插件只要 id 出现在文件里——无论是作为顶栏布局条目、`plugins[]` 里的条目还是 `bar.id`——就被启用。第一方的非顶栏插件刚好相反：默认开启，只有出现在 `disabledPlugins[]` 列表里才关掉。

完整的顶栏插件没有关闭状态。永远只有一个顶栏，所以换一个顶栏启用另一个就行。顶栏小组件的位置见 [顶栏](05-the-top-bar.md)。

## 从 git 添加插件

第三方插件就是一个 git 仓库，根目录有 `manifest.json`。

```
omarchy plugin add https://github.com/acme/omarchy-weather.git --enable
```

在动手之前，它会明确告诉你插件以任意、非沙箱代码的形式在你的长期 shell 进程里运行，显示 URL，然后让你确认。认真对待这个提示。第三方插件接口不直接暴露认证服务，替换型顶栏对配置好的非认证 UI 也只提供有限能力。视觉插件仍共享 shell 的 QML 场景并能遍历普通父对象，而且所有插件代码都在你的用户账号权限下运行。认证状态单独通过把那些服务放在可遍历的宿主对象图之外来保护。只加你愿意运行的仓库，启用前先读代码。

替换型顶栏可以渲染已安装的小组件，但依赖服务的第三方小组件可能功能受限——因为顶栏被禁止请求另一个插件的实时服务对象。如果某个小组件需要它的 companion 服务，切回内置的 `omarchy.bar`。

然后它会把仓库克隆到临时目录、验证 manifest、如果其他插件已占用该 id 就拒绝安装、最后移动到 `~/.config/omarchy/plugins/<id>/`。不加 `--enable` 的话会问你要不要现在启用，可以说不先读代码。它永远不会运行插件里的任何东西，永远不会执行安装钩子，永远不会请求 sudo——它只是克隆文件、检查 manifest、通过 IPC 翻转一个开关。

更新就是对同一个 checkout 做快进 pull：

```
omarchy plugin update acme.weather
omarchy plugin update
```

不带 id 就更新所有 git 管理的插件。应用前会展示 diff，如果有本地改动无法快进就拒绝更新，如果新版本验证失败就回滚。

```
omarchy plugin remove acme.weather
```

移除时先禁用插件，然后如果是 git checkout 就删除仓库（上游还在），如果是符号链接就 unlink。没有 git 仓库的手工插件文件夹会移动到插件目录里带时间戳的备份，而不是直接删除。

## 克隆内置插件来修改

这是我最喜欢的部分。想改内置小组件的行为，别去编辑 `$OMARCHY_PATH` 下的文件——它们属于包，下次更新就会被覆盖。克隆它：

```
omarchy plugin clone omarchy.clock
```

这会把整个插件复制到 `~/.config/omarchy/plugins/dhh.clock`（用你的用户名，不是我的），重命名为 "My Clock"，启用它，并让 shell 从内置切到你的副本——保留已有顶栏小组件的位置和设置。加 `--edit` 可以立即在 `$EDITOR` 里打开新目录，菜单里的 _Setup > Plugins > Clone Plugin_ 也是这么做的。

用户名前缀保证你的克隆版 id 归你所有，分享出去也不会和别人冲突。对原内置 id 的调用会路由到你的克隆版，所以任何引用 `omarchy.clock` 的东西都不用改。搞砸了就 `omarchy plugin remove dhh.clock`，内置版自动回来。

在 `~/.config/omarchy/plugins/` 下任何地方保存文件都会自动重新加载插件代码，所以开着编辑器就能看着变化落地。

## 自己写

插件就是一个目录，里面有 `manifest.json` 和一些 QML。manifest 声明 `schemaVersion: 1`、一个 `id`、`name`、`version`、一个或多个 `kinds`，以及一个 `entryPoints` 对象指向每个 kind 对应的 QML 文件：

| Kind | 是什么 |
|------|------------|
| `bar-widget` | 活动顶栏可以放进某一段的组件 |
| `panel` | 持久的或召出的浮动窗口 |
| `overlay` | 全屏覆盖层 |
| `menu` | 召出的菜单表面 |
| `service` | 没有 UI 的无头单例 |
| `bar` | 完整顶栏，替换内置的 |

一个插件可以同时声明多个 kind——媒体插件就是 `service` 和 `bar-widget` 两种。顶栏小组件有额外的 `barWidget` 块，带显示名、分类、可选的 `defaultSection` 和 `allowMultiple`（表示顶栏上放多个有没有意义）。大部分小组件设为 `false`；spacer 和指示器设为 `true`。

发布前检查一下：

```
omarchy plugin validate ./my-plugin
```

它运行和 shell 加载时一样的检查：schema 版本、必需字段、不被保留的 id、entry point 是安全的相对路径且确实存在、每个 kind 都有 entry point、文件夹里没有任何符号链接。

想了解全貌，源码就是文档：Omarchy 仓库里的 `shell/README.md` 覆盖了 manifest schema、shell 的 IPC 契约和 `shell.json` 的确切结构，`shell/plugins/README.md` 列出了每个第一方插件的 id、kind 和 entry point。

## 分享出去

做出自己喜欢的东西后，放到公开的 git 仓库里就行。这就是完整的分发机制——任何人都可以 `omarchy plugin add` 你的 URL，几秒钟就能跑起来。

想让别人容易找到，到 [omarchyplugins.com](https://omarchyplugins.com) 列出来。那是社区的 codeOS Shell 插件目录，也是你在想"有没有人已经写了我要做的小组件"时首先该看的地方。开始写之前先逛一圈！
