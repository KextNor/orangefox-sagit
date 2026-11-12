> [!IMPORTANT]
> **刷入之前，请务必先阅读下方的「刷入与测试」教程。**
>
> **维护者：ZiLing_Fox** —— 遇到任何问题千万要提 [Issue](https://github.com/KextNor/orangefox-sagit/issues/new?template=bug_report.yml) 告诉开发者，不然就没法修 bug 了 xwx

# OrangeFox Recovery R12 for Xiaomi Mi 6 (sagit)

非官方（Unofficial）的 OrangeFox Recovery R12 构建，设备树 + GitHub Actions 自动编译。

- 源码基线：OrangeFox `fox_12.1`（`FOX_INTERNAL_RELEASE = R12.0`）
- 版本号：`R12.0_1`
- 维护者：ZiLing_Fox
- 所有 polaris 的功能和改进同步应用到 sagit
- 感谢🐾白墨🐾Whiteink🐾给 polaris 提出的建议
---

## 一、刷入与测试（先看这里）

### 1. 下载

到 [Releases](https://github.com/KextNor/orangefox-sagit/releases) 下载最新的：

- `OrangeFox-R12.0_1-Unofficial-sagit.img` —— 用 fastboot 刷
- `OrangeFox-R12.0_1-Unofficial-sagit.zip` —— 在已有 Recovery 里刷

解压/下载后建议用附带的 `.md5` 校验一下完整性。

### 2. 前置检查

```bash
fastboot devices                     # 能看到设备
fastboot getvar unlocked             # 必须返回 yes，否则先解锁 bootloader
```

### 3. 方式 A：fastboot 刷入（推荐）

```bash
fastboot erase recovery
fastboot flash recovery OrangeFox-R12.0_1-Unofficial-sagit.img
fastboot reboot recovery
```

### 4. 方式 B：刷 zip（已有 Recovery 时最稳）

把 `.zip` 拷进手机，在现有 Recovery 里直接选它安装。

### 5. 方式 C：临时启动（不进分区，用来验证镜像是否正常）

```bash
fastboot boot OrangeFox-R12.0_1-Unofficial-sagit.img
```

临时进入后，可在 Recovery 内 → **安装 → 安装镜像 → 选择 `recovery.img` → 目标分区选 Recovery**，把镜像写进分区。

> `fastboot boot` 只是临时加载，重启后不会保留。

### 6. 进入 Recovery

关机状态下按住 **电源键 + 音量上键**，出现小米 Logo 后松开。

### 7. 常用快捷键

| 功能 | 快捷键 | 备注 |
|------|--------|------|
| 截屏 | 尝试 **音量下 + 电源键** 或 **音量上 + 电源键** | 文件存 `/sdcard/Fox/Screenshots/`；也可在 **设置 → 自定义** 里确认/修改 |
| 强制重启 | 长按电源键 10 秒 | |
| 退出 Recovery | **重启 → 系统** | |

### 8. 时区设置

本构建通过 `OF_DEFAULT_TIMEZONE` 默认设为 **Asia/Shanghai (CST, UTC+8)**，进入 Recovery 后时间应该就是准的。

如果你需要手动改：

→ **设置 → 通用 → 时间 → 选择时区**

> **注意：** OrangeFox 内置时区列表里没有直接的 China/Shanghai 选项。列表里的 `TAIST-8`（台湾时间）也是 UTC+8，但带夏令时。如果不想要夏令时，用 `OF_DEFAULT_TIMEZONE="CST-8"`（POSIX 格式，无夏令时）是最干净的做法。

### 9. Magisk 功能

本 Recovery 内置 OrangeFox 的 **Advanced → Magisk** 功能，不需要额外刷包：

- **Patch Boot image**：把 ROM 的 boot.img 打上 Magisk 补丁，生成 `magisk_patched-*.img`，然后 fastboot 刷入。
- **Direct install**：直接给当前 boot 分区打补丁（需要已 root）。
- **Uninstall Magisk**：仅卸载 Magisk 管理的模块和镜像，不会破坏系统。

> 如果刷了 Magisk 之后系统起不来，在 Recovery 里 → **高级 → Magisk → Uninstall** 或直接手动备份的 boot.img 刷回去即可。

### 10. Fox Addons 使用

刷 ROM 时（从 Recovery 里刷 ZIP 包），OrangeFox 会弹出 **Fox Addons** 页面，让你选择是否同时注入 Magisk、是否备份 vendor 等。**这不是 Recovery UI 里的插件中心**，只在刷 ROM 的流程中出现。

本构建已取消 `FOX_VANILLA_BUILD`，所有 Fox Addons 默认启用。

### 11. 常见问题

| 现象 | 说明 / 处理 |
|------|-------------|
| 卡在 `sending 'recovery'` | 换 USB 2.0 口、原装线，或改用方式 C |
| 刷入成功但按键进不去、黑屏重启 | 用方式 C 临时启动后，在 Recovery 内刷入镜像 |
| 能进 Recovery 但看不到内部存储 | `/data` 未能解密。sagit 是 keymaster 3.0（msm8998 硬件限制），对 Android 12+ ROM 的 FBE 可能不兼容 |
| 刷完重启又变成官方 Recovery | MIUI/HyperOS 会还原 recovery，刷完请立即进入并刷一次 OrangeFox zip |
| 类原生 ROM 覆盖 Recovery | LineageOS / RisingOS / Pixel Experience 等刷完 ROM 后会刷回自己的 recovery，需用方式 C 临时启动后固化 |

### 12. 回退

保留一份官方 OrangeFox R9/R10 包作为回退。

---

## 二、版本信息

| 项目 | 值 |
|------|-----|
| 发行版本 | R12.0_1 |
| 构建类型 | Unofficial |
| 源码分支 | fox_12.1 |
| 维护者 | ZiLing_Fox |
| SoC | Qualcomm MSM8998 Snapdragon 835 |
| 分区表 | A-only（非动态分区） |
| Keymaster | 3.0（msm8998 硬件限制） |

`FixN-` 前缀只是 GitHub Release 的发布序号，不影响 Recovery 内部显示的版本号。

---

## 三、设备规格

| Device | Xiaomi Mi 6 |
|--------|-------------|
| SoC | Qualcomm MSM8998 Snapdragon 835 |
| CPU | 4x Kryo 280 @ 2.45GHz + 4x Kryo 280 @ 1.9GHz |
| GPU | Adreno 540 |
| Memory | 4GB / 6GB RAM (LPDDR4X) |
| Storage | 64GB / 128GB UFS 2.1 |
| Battery | 3350 mAh Li-Po |
| Display | 5.15" IPS, 1920x1080, 428 PPI, 60Hz |

---

## 四、内置功能

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
| Keymaster | 3.0 | msm8998 硬件限制，不支持 keymaster 4.0 |

---

## 五、如何编译

### 使用 GitHub Actions

1. 向 `main` 分支推送提交（会自动触发），或在 **Actions** 页面手动 `Run workflow`
2. 等待完成（约 20 分钟）
3. 构建成功后会自动创建 Release，同时产物也可在 **Artifacts** 下载

### 本地编译

```bash
# 同步 OrangeFox 源码
mkdir ~/OrangeFox_sync && cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git
cd sync
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1

# 放置设备树
cd ~/fox_12.1
git clone https://gitlab.com/OrangeFox/device/sagit.git -b fox_9.0 device/xiaomi/sagit
# 然后把本仓库的文件覆盖进去（BoardConfig.mk / twrp_sagit.mk / device.mk / ...）

# 编译
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=sagit
export LC_ALL="C"
source build/envsetup.sh
lunch twrp_sagit-eng
mka adbd recoveryimage
```

产物位于 `out/target/product/sagit/`。

### 注意事项

- sagit 没有 common 树依赖，所有配置在设备树内
- sagit 是 A-only 设备，不使用动态分区
- sagit 使用 keymaster 3.0（msm8998 硬件限制），**不能**设 `FOX_USE_KEYMASTER_4=1`

---

## 六、Credits

- [OrangeFox Recovery Project](https://gitlab.com/OrangeFox)
- 官方设备树：[sagit fox_9.0](https://gitlab.com/OrangeFox/device/sagit)（改造为 fox_12.1 构建）

## 七、License

GPL v3
