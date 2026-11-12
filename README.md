# MyMPV V0.1

MyMPV 是面向 Windows 的个人 mpv 配置，侧重忠实呈现画面、字幕体验和按需画质增强。项目使用现有的 `D:\_Software\Video\MPV-V3 20261106\mpv.exe`，无需重新安装或修改播放器内核。

## 启动方法

```powershell
& 'D:\_Software\Video\MPV-V3 20261106\mpv.exe' --config-dir='D:\_Software\Video\MyMPV\portable_config' 'D:\path\to\video.mkv'
```

运行配置位于独立的 `portable_config` 目录，通过 `--config-dir` 加载。`portable_config/script-opts/thumb_engine.conf` 中的缩略图引擎也指向上述 mpv 程序；如果移动播放器，请同步更新该路径。

## 快捷键

| 按键 | 操作 |
| --- | --- |
| Ctrl+1 / Ctrl+2 / Ctrl+3 | Original（原始画质）/ Cinema（电影增强）/ Anime（动漫增强） |
| p / b | 打开播放列表 / 本地文件浏览器 |
| Alt+s | 打开字幕轨菜单，可选择次字幕 |
| Alt+Shift+s | 切换次字幕轨 |
| 鼠标右键 | 打开中文 uosc 菜单 |
| i / Shift+i | 临时显示 / 持续显示统计信息 |
| Q | 退出并保存当前文件的播放进度 |

uosc 菜单提供播放列表切换与移除、本地文件浏览、音量调节和轨道选择。也可以将本地文件拖入 mpv 打开。每次打开新文件都会回到 Original 模式；Cinema 和 Anime 需手动启用。mpv 的 watch-later 按文件保存播放进度和所选轨道，`saved-props.json` 在全局范围保存音量和静音状态。

更多细节见[架构设计](docs/ARCHITECTURE.md)、[功能状态](docs/FEATURES.md)、[依赖清单](docs/DEPENDENCIES.md)和[测试记录](docs/TESTING.md)。

当前日常使用以 SDR 播放为主。用户已用真实视频验收三种画质模式切换、字幕显示、Q 退出后的进度恢复及主要界面操作；HDR 输出和 HDR 片源转 SDR 的效果仍待专项验证。

## 文档语言规范

项目说明、开发文档、测试报告及面向用户的功能说明默认使用简体中文。代码标识符、配置语法、命令、路径、第三方原文及许可证原文保持原样。
