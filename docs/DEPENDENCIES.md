# 依赖组件与来源

选用基线为本地 `sources/mpv_PlayKit` 的 main 分支提交 `dddb196f02c467224b4e1fb30228bd70d6f3b433`（2026-11-09）。[作者的 README](https://github.com/hooke007/mpv_PlayKit) 将 main 描述为当前及历史文件集合、lite 描述为懒人包核心配置，并将 [Releases](https://github.com/hooke007/mpv_PlayKit/releases) 作为可直接使用的发行来源。本地没有 Release 压缩包，因此 V0.1 只从已检查的 main 工作树中选取下表组件。

| 组件 | 来源与版本 | 用途 | 运行依赖 | 启用状态与许可证 |
| --- | --- | --- | --- | --- |
| mpv | 现有 Windows x86-64-v3 构建，0.42.0-3-g902818753 | 播放器、libass、gpu-next | Windows / D3D11 | 外部程序；[mpv 版权信息](https://github.com/mpv-player/mpv/blob/master/Copyright) |
| uosc 子目录 | 复制自 PlayKit；上游 uosc 5.12.1，提交 `41040532f840b8089ae1bedba906071959347771` | 界面、菜单、文件浏览 | mpv Lua、随附图标字体 | 已启用；[uosc LGPL](https://github.com/tomasklaen/uosc/blob/main/LICENSE.LGPL)，随附 fzy 文件含 MIT 许可声明 |
| thumb_engine 子目录 | PlayKit main，基于 po5/thumbfast 分支修改 | 悬停缩略图 | 现有 mpv 程序、Windows LuaJIT | 已启用；再分发前需核查 PlayKit 修改部分的许可证；[thumbfast 许可证](https://github.com/po5/thumbfast/blob/master/LICENSE)只覆盖其上游代码 |
| stats.lua | PlayKit main，源自 mpv stats | 媒体与渲染信息 | `load-stats-overlay=no` | 已启用；[mpv 版权信息](https://github.com/mpv-player/mpv/blob/master/Copyright)，再分发前需核查 PlayKit 修改部分 |
| save_global_props.lua | PlayKit main | 全局音量与静音记忆 | 配置目录的写入权限 | 已启用；文件中未识别到许可证，再分发前需核查 |
| FSRCNNX fastv2 | PlayKit main 着色器 | Cinema 模式的缩放增强 | gpu-next、D3D11 | 按需启用；复制的文件中未识别到许可证，再分发前需核查 |
| Anime4K Restore Soft S + Upscale CNN x2 S | PlayKit main 着色器 | Anime 模式的画质增强 | gpu-next、D3D11 | 按需启用；两个文件均包含 MIT 许可声明 |
| MaterialIconsRound + uosc_textures | PlayKit main 字体 | uosc 图标绘制 | mpv 字体加载器 | 已启用；发布整合包前需核查字体再分发条款 |
| quality_mode.lua | MyMPV V0.1 | 模式互斥切换与清空 | mpv Lua | 已启用；项目自有代码 |

PlayKit 可选的 FFmpeg 批量缩略图、MediaInfo 统计扩展、yt-dlp、VapourSynth 脚本、uosc_addones 和额外字体加载均未启用，也不是本配置的运行前提。未安装额外的可执行程序。
