# 测试记录与已知限制

测试环境：Windows，mpv 0.42.0-3-g902818753（2026-11-06 构建）。所有测试都通过 `--config-dir=D:\_Software\Video\MyMPV\portable_config` 指定配置目录，并使用现有的 `mpv.com`。日志位于 `tests/`，已由 Git 忽略。`tests/quality_mode_check.lua` 在运行时发送模式切换命令，并断言着色器列表长度依次为 1 → 2 → 0。

| 测试项目 | 结果 |
| --- | --- |
| 使用 lavfi 640×360 测试画面启动配置和脚本 | 已验证（`smoke.log`）；未发现致命配置错误或 Lua 错误。 |
| 启动 D3D11 gpu-next | 已验证（`final-gpu-modes.log`）；DISPLAY1 报告为 3840×2160、8-bit SDR。 |
| Original → Cinema → Anime → Original | 已验证（`final-gpu-modes.log`）；一个 FSRCNNX 着色器、两个 Anime4K 着色器依次加载，最后清空。较早的编译日志（`gpu-modes.log`）报告 shaderc 错误数为 0。 |
| 解析 ASS/SRT 字幕 | 已验证（`final-subtitles.log`）；两条轨道均被识别，libass 已初始化。实际显示效果仍需人工检查。 |

## 用户人工验收

用户已使用真实视频确认：Original、Cinema、Anime 三种模式可以切换；ASS、SRT 和双语字幕显示正常；大写 Q 退出后重新打开视频可恢复播放位置；1080p 和 4K 视频主观播放流畅，未发现明显丢帧；uosc 控制界面可显示，右键可打开中文 uosc 菜单；进度条悬停缩略图、文件浏览器和播放列表正常。这些是人工观察结果，不等同于长期稳定性测试或精确丢帧测量。

**仍需专项验证：**用户目前关闭 Windows HDR，原因是显示器的 HDR 观感不理想，因此 HDR 输出测试暂缓；HDR 片源转换到 SDR 的实际效果也尚未专项验证。尚未完成长期稳定性和精确丢帧统计。高 DPI 细节、播放列表移除条目、全局音量与静音记忆、同名本地字幕自动匹配、主次字幕手动切换、具体 ASS 特效与中文字体回退均未得到明确的单项人工验收记录。Cinema、Anime 的画质和性能也需按真实片源继续评估。

上述人工验收与前面的自动化记录分别保留。合成测试画面只证明配置启动、轨道解析和着色器状态变化，不代替真实视频的观感检查。

`thumb_engine` 指向当前 mpv 的绝对路径；移动播放器后需编辑 `script-opts/thumb_engine.conf`。`saved-props.json` 和 `watch_later/` 属于运行数据，更新配置时应保留。本项目目前供本地使用；再分发复制的脚本、着色器或字体前，仍需核查第三方许可证。

色彩策略：`target-colorspace-hint=auto` 遵循 mpv 对 D3D11 显示设备的检测。[mpv 官方文档](https://mpv.io/manual/master/#options-target-colorspace-hint)指出，ICC 配置文件的优先级高于输出色彩空间元数据。确认实际显示器和 HDR 行为后，可考虑使用 `icc-profile-auto=yes` 启用经过校准的 SDR ICC；V0.1 不强制启用。
