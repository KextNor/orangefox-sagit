> [!IMPORTANT]
> **刷入之前，请务必先阅读下方的「刷入与测试」教程。**
>
> **维护者：ZiLing_Fox** —— 遇到任何问题千万要提 [Issue](https://github.com/KextNor/orangefox-sagit/issues/new?template=bug_report.yml) 告诉开发者，不然就没法修 bug 了 xwx

# OrangeFox Recovery R12 for Xiaomi Mi 6 (sagit)

非官方（Unofficial）的 OrangeFox Recovery R12 构建，设备树 + GitHub Actions 自动编译。

- 源码基线：OrangeFox `fox_12.1`（`FOX_INTERNAL_RELEASE = R12.0`）
- 版本号：`R12.0_1`
- 维护者：ZiLing_Fox
- 同 polaris，所有 polaris 的功能和改进同步应用到 sagit

---

## 一、刷入与测试（先看这里）

### 1. 下载

到 [Releases](https://github.com/KextNor/orangefox-sagit/releases) 下载最新的：

- `OrangeFox-*.img` —— 用 fastboot 刷
- `OrangeFox-*.zip` —— 在已有 Recovery 里刷

### 2. 前置检查

```bash
fastboot devices
fastboot getvar unlocked             # 必须返回 yes
```

### 3. 方式 A：fastboot 刷入（推荐）

```bash
fastboot erase recovery
fastboot flash recovery OrangeFox-*.img
fastboot reboot recovery
```

### 4. 方式 B：刷 zip

把 `.zip` 拷进手机，在现有 Recovery 里直接选它安装。

### 5. 方式 C：临时启动（不进分区）

```bash
fastboot boot OrangeFox-*.img
```

### 6. 关于类原生 ROM 覆盖 Recovery

**重要：** 刷 LineageOS / AxionOS / RisingOS / Pixel Experience 等类原生 ROM 时，ROM 的 postinstall 会刷回自己的 recovery。刷完 ROM 后请立即：

```bash
fastboot flash recovery OrangeFox-*.img
```

或者用方式 C 临时启动后，在 OrangeFox 里刷一次 OrangeFox ZIP 固化。

### 7. 回退

保留一份官方 OrangeFox R9/R10 包作为回退。

---

## 二、内置功能

| 功能 | 状态 | 说明 |
|---|---|---|
| 维护者信息 About | ✅ | ZiLing_Fox + 圆形透明头像 |
| Credits 顶格 | ✅ | 自动对齐官方原文缩进 |
| 默认时区 | ✅ | Asia/Shanghai (CST-8, 无夏令时) |
| Fox Addons | ✅ | Magisk / MIUI OTA / MIUI vendor backup / FRP 擦除（取消 FOX_VANILLA_BUILD） |
| FRP 擦除 | ✅ | OF_ENABLE_FRP_ADDON=1 |
| Magisk 内置 | ✅ | 源码内置 Magisk ZIP，Fox Addons 页面可选 |
| 手电筒 | ✅ | OF_FLASHLIGHT_ENABLE=1（默认 LED 路径） |
| 截屏 | ✅ | 音量上 + 电源键，存到 /sdcard/Fox/Screenshots/ |

### 截屏快捷键

在任意界面按 **音量上 + 电源键** 即可截屏，图片自动保存到 `/sdcard/Fox/Screenshots/`。也可以在设置里搜 `screenshot` 自定义。

### 时区设置

如果默认 Asia/Shanghai 不适合你，进 **设置 → 区域设置** 手动改。

### Fox Addons 使用

刷 ROM 时（从 Recovery 里刷 ZIP 包），OrangeFox 会弹出 **Fox Addons** 页面，让你选择是否同时注入 Magisk、是否备份 vendor 等。**这不是 Recovery UI 里的插件中心**，只在刷 ROM 的流程中出现。

### 问题反馈

请先收集日志再提 Issue：
- fastboot 阶段：`fastboot flash recovery xxx.img > flash.log 2>&1`
- Recovery 内：`/sdcard/Fox/logs/`（`recovery.log`、`last_log`、`dmesg`）
- adb：`adb pull /tmp/recovery.log`

---

## 三、版本信息

| 项目 | 值 |
|---|---|
| 发行版本 | R12.0_1 |
| 构建类型 | Unofficial |
| 源码分支 | fox_12.1 |
| 维护者 | ZiLing_Fox |
| SoC | Qualcomm SDM835 Snapdragon 835 |
| 分区表 | A-only（非动态分区） |
| 分区修复 | cust 已保留，无 formattable 补丁（A-only 不需要） |

---

## 四、设备规格

| Device | Xiaomi Mi 6 |
|---|---|
| SoC | Qualcomm SDM835 Snapdragon 835 |
| CPU | 4x Kryo 280 @ 2.45GHz + 4x Kryo 280 @ 1.9GHz |
| GPU | Adreno 540 |
| Memory | 4GB / 6GB RAM (LPDDR4X) |
| Storage | 64GB / 128GB UFS 2.1 |
| Battery | 3350 mAh Li-Po |
| Display | 5.15" IPS, 1920x1080, 428 PPI, 60Hz |

---

## 五、Credits

- [OrangeFox Recovery Project](https://gitlab.com/OrangeFox)
- 官方设备树：[sagit fox_9.0](https://gitlab.com/OrangeFox/device/sagit)（改造为 fox_12.1 构建）

## 六、License

GPL v3
