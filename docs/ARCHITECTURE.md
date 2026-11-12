# 架构设计

`portable_config` 是唯一的运行配置目录。`mpv.conf` 管理渲染、色彩、字幕默认值和状态保存；`input.conf` 管理项目快捷键。mpv 会自动加载 `scripts/` 中的脚本，各脚本的选项放在 `script-opts/`。

从 PlayKit 选用的组件包括 `uosc/` 及其两种图标字体、`thumb_engine/`、`stats.lua`、`save_global_props.lua` 和三个着色器文件。原始 PlayKit 目录保留在 `sources/mpv_PlayKit` 供对照，所选上游脚本均未修改。`quality_mode.lua` 是 MyMPV 自有代码：每次切换模式时整体替换 `glsl-shaders` 列表，并在 `start-file` 事件中为下一个视频清空该列表。三个模式共用 `mpv.conf` 中的色彩设置。

冲突管理：uosc 是唯一启用的屏幕控制界面（OSC，`osc=no`）；thumb_engine 是唯一的缩略图提供者；PlayKit stats 取代 mpv 内置统计叠加层（`load-stats-overlay=no`）。watch-later 按文件保存进度和轨道，save_global_props 在全局范围保存音量与静音状态。未加载 uosc_addones、stats_mediainfo、字幕下载器、fontconfig 覆盖配置、LUT、VapourSynth 或额外菜单扩展。

PlayKit 的 `main` 分支同时包含可运行的 `mpv.conf`、`input.conf`、`scripts/`、`script-opts/`、`shaders/`、`fonts/`，以及 `input_*.conf`、`profiles.conf`、`fonts.conf` 等示例、未使用资源和历史方案。mpv 会自动加载顶层 `.lua`、`.js` 脚本及可识别的脚本子目录；整包复制会启用无关功能。`profiles.conf` 仅在被显式包含时生效。所选 uosc 和缩略图模块需要完整子目录，uosc 图标还需要两种字体；画质模式只需要已复制的三个 `.glsl` 文件。

Windows 平台使用 D3D11 gpu-next、自动输出色彩空间提示和 DirectWrite 字体回退。在显示器的 HDR 能力尚未确认前，不强制指定 ICC、峰值亮度、色域或传递函数。`thumb_engine` 使用现有 mpv 程序生成单帧缩略图，未使用可选的 FFmpeg 批量路径。配置不会递归扫描目录，也不会修改系统注册信息。
