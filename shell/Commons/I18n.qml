pragma Singleton
import QtQuick
import Quickshell.Io

// Internationalization singleton. Provides t() / tr() for looking up
// translated UI strings from JSON language files under shell/i18n/.
//
// Locale is resolved in three steps:
//   1. shellConfig.language  (explicit user override in shell.json)
//   2. system LANG env var   (e.g. "zh_CN.UTF-8" → "zh-CN")
//   3. fallback "en-US"      (strings in the en-US file act as the canonical source)
//
// The lookup key is a dotted path like "lock.placeholder" that maps into the
// nested JSON structure. If the key is missing in the active language file the
// caller gets back the original key name, so the UI still renders something
// readable while translations are being completed.
QtObject {
  id: root

  // Two-letter locale or full tag, e.g. "en", "en-US", "zh", "zh-CN".
  property string language: resolvedLanguage
  readonly property string resolvedLanguage: resolveLanguage()

  // Loaded translation table for the active language. Starts with a safety
  // copy of en-US so every t() call has *something* to return.
  property var translations: {}
  property var enBackup: {}

  readonly property string i18nDir: Quickshell.env("OMARCHY_PATH") + "/shell/i18n"

  function resolveLanguage() {
    var cfg = (typeof shellConfig !== "undefined" && shellConfig && shellConfig.language)
      ? String(shellConfig.language)
      : ""
    if (cfg.length > 0) return normalize(cfg)

    var lang = Quickshell.env("LANG") || Quickshell.env("LANGUAGE") || "en_US.UTF-8"
    return normalize(lang)
  }

  function normalize(raw) {
    // "zh_CN.UTF-8" → "zh-CN", "en_US.UTF-8" → "en-US", "en" → "en-US"
    var primary = String(raw || "en")
      .split(".")[0]           // drop encoding suffix
      .replace("_", "-")       // zh_CN → zh-CN
      .toLowerCase()
    if (primary === "zh") return "zh-CN"
    if (primary === "en") return "en-US"
    return primary
  }

  // Deep-merge `src` into `dst`. Called after loading both en-US and the
  // active language so we fill gaps from the English canonical source.
  function merge(dst, src) {
    if (!src || typeof src !== "object") return
    for (var key in src) {
      if (Object.prototype.hasOwnProperty.call(src, key)) {
        var val = src[key]
        if (val && typeof val === "object" && !Array.isArray(val)) {
          if (!dst[key] || typeof dst[key] !== "object") dst[key] = {}
          merge(dst[key], val)
        } else {
          dst[key] = val
        }
      }
    }
  }

  // Load a JSON file from the i18n directory. Returns null on failure.
  function loadFile(tag) {
    var path = i18nDir + "/" + tag + ".json"
    var file = Quickshell.Io.File.readText(path)
    if (!file || !file.text) return null
    try { return JSON.parse(file.text) } catch (e) { return null }
  }

  // Refresh translations for the current language. Called automatically when
  // `language` changes; also callable via omarchy-refresh-shell or plugin
  // reload so edits to the JSON file are picked up at runtime.
  function reload() {
    enBackup = loadFile("en-US") || {}
    var active = loadFile(resolvedLanguage) || {}
    // Start from English defaults so missing keys fall through.
    var merged = JSON.parse(JSON.stringify(enBackup))
    merge(merged, active)
    translations = merged
  }

  // Look up a dotted key like "lock.placeholder". Returns the lookup key
  // itself when nothing is found, so callers always get a non-empty string.
  function t(key, fallback) {
    if (!key || typeof key !== "string") return fallback || ""
    if (!translations || Object.keys(translations).length === 0) reload()

    var parts = key.split(".")
    var node = translations
    for (var i = 0; i < parts.length; i++) {
      if (!node || typeof node !== "object") return fallback !== undefined ? fallback : key
      node = node[parts[i]]
      if (node === undefined) return fallback !== undefined ? fallback : key
    }

    if (typeof node === "string") return node

    // Not a leaf string — caller asked for a section, return the dotted key.
    return fallback !== undefined ? fallback : key
  }

  // Convenience: tr() is Qt's built-in marker, kept as an alias for
  // Qt Linguist compatibility if we ever migrate to .ts files.
  function tr(key, fallback) { return t(key, fallback) }

  Component.onCompleted: reload()

  onLanguageChanged: reload()
}
