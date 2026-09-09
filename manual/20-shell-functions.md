# Shell 函数

codeOS 自带一组 Shell 函数，简化常见任务并封装复杂的参数调用。

## 压缩

- `compress [file/dir]`: 把文件或目录打成 tar.gz 包。
- `decompress [file.tar.gz]`: 展开 tar.gz 文件。

## 磁盘

- `iso2sd [image.iso]`: 用指定 iso 文件在 SD 卡上创建启动盘，交互式选择设备。
- `format-drive [device] [name]`: 格式化整个磁盘为单个 exFAT 分区（Windows 和 macOS 都能用）。不带参数运行看看可用磁盘。小心操作！

## 开发布局

一键创建 Tmux 多分屏开发布局：

- `tdl [ai]`: 创建 Tmux 开发布局，含编辑器、AI Agent 和终端。用 Agent 别名，比如 `tdl c` 是 opencode、`tdl cx` 是 Claude Code，或传两个 Agent 同时运行，如 `tdl c cx`。
- `tds`: 创建 Tmux 开发方形布局，含编辑器、diff 观察（通过 `hunk diff --watch`）、终端和 opencode。
- `tdlm [ai]`: 为当前目录的每个子目录创建一个 `tdl` 窗口。
- `tsl [count] [command]`: 创建一个网格排列的分屏群，全部运行同一命令（对 AI Agent 特别有用）。

Herdr 里同样的布局是 `hdl`、`hds`、`hdlm` 和 `hsl`。

## Git worktree

- `ga [branch]`: 在当前仓库旁边创建新 worktree 和分支并跳进去。
- `gd`: 删除当前 worktree 及其分支（会先确认）。

## Rsync 观察器

- `rsw [source] [destination]`: 启动后台观察器，任何变化就 rsync 源到目标。目标可以是远程主机，如 `rsw ~/Work/app nyc-dev:Work/app`。
- `lsw`: 列出所有活跃的观察器。
- `dsw`: 停止所有活跃的观察器。

## SSH 端口转发

适合 Web 开发时在远程机器上用 localhost 安全上下文权限。

- `fip`: 通过 SSH 把远程主机的一个或多个端口转发到 localhost。
- `dip`: 断开一个或多个转发端口。
- `lip`: 列出所有活跃的 SSH 端口转发。

比如你在一台叫 `nyc-dev` 的机器上启动了 `3000` 端口的开发服务器，运行 `fip nyc-dev 3000` 就能把那个端口转发过来，这样 `localhost:3000` 实际访问的是 `nyc-dev:3000`，不需要 SSL 证书就能建立 WebSocket 等需要的安全上下文。

## SSH 重连

`ssh` 本身被包装在一个函数里：当远程 tmux、Herdr 或编辑器还占着终端时连接断了会清理终端，然后交互式会话断掉时自动重连（Ctrl-C 停止重试循环）。
