# 📦 1Panel 第三方应用仓库 (Unofficial 1Panel Third-Party Application Repository)

<p align="left">
  <a href="https://github.com/Coinsinical/appstore/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/Coinsinical/appstore.svg?style=for-the-badge" alt="Contributors">
  </a>
  <a href="https://github.com/Coinsinical/appstore/issues">
    <img src="https://img.shields.io/github/issues/Coinsinical/appstore.svg?style=for-the-badge" alt="Issues">
  </a>
  <a href="https://github.com/Coinsinical/appstore/stargazers">
    <img src="https://img.shields.io/github/stars/Coinsinical/appstore.svg?style=for-the-badge" alt="Stars">
  </a>
</p>

这是一个由社区驱动和维护的、**非官方**的 [1Panel](https://github.com/1Panel-dev/1Panel) 应用仓库，适配1Panel V2，旨在为 1Panel 用户提供更多官方商店之外的应用选择和优化版本。

---

## 🚨 重要声明

> **1. 非官方性质**
> 本仓库**并非** 1Panel 官方维护的应用商店。所有应用均由社区贡献者提交，**未经 1Panel 官方团队的审核、测试或背书**。
>
> **2. 风险自负**
> 我们无法保证本仓库中所有应用的安全性、稳定性或及时更新。在安装和使用这些应用前，您应**自行评估潜在的风险**。
>
> **3. 免责声明**
> 对于因使用本仓库中任何应用而导致的任何数据丢失、安全漏洞、服务中断或任何直接、间接损失，**1Panel 官方团队和本仓库维护者均不承担任何责任**。
>
> **4. 优先官方**
> 我们强烈建议您**始终优先使用 1Panel 官方应用商店**中提供的应用。

---

## 🎯 仓库收录原则

本仓库旨在作为 1Panel 官方应用商店的补充，主要收录以下两类应用：

* ✅ **官方暂未收录的应用**：经过测试、有一定使用价值，但尚未被 1Panel 官方商店收录的开源应用。
* 🚀 **官方应用的优化版**：针对 1Panel 官方商店中已有的应用，提供的配置优化、功能增强或特定场景的修改版本。

---

## ⚙️ 如何使用
### 方法一：使用 git 命令获取应用

`1Panel`计划任务类型`Shell 脚本`的计划任务框里，添加并执行以下命令，或者终端运行以下命令，
```shell
git clone -b dev https://github.com/Coinsinical/appstore /opt/1panel/resource/apps/local/appstore-localApps

cp -rf /opt/1panel/resource/apps/local/appstore-localApps/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-localApps
```

然后应用商店刷新本地应用即可。

#### 方法二：使用压缩包方式获取应用

`1Panel`计划任务类型`Shell 脚本`的计划任务框里，添加并执行以下命令，或者终端运行以下命令
```shell
wget -P /opt/1panel/resource/apps/local https://github.com/Coinsinical/appstore/archive/refs/heads/dev.zip

unzip -o -d /opt/1panel/resource/apps/local/ /opt/1panel/resource/apps/local/dev.zip

cp -rf /opt/1panel/resource/apps/local/appstore-dev/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-dev

rm -rf /opt/1panel/resource/apps/local/dev.zip
```

然后应用商店刷新本地应用即可。

---

## 📋 应用列表
| 应用名称 | 描述 | 版本 | 类型 | 维护者 |
| :--- | :--- | :--- | :--- | :--- |

---
## 🐛 问题反馈

如果您在使用本仓库的应用时遇到任何问题（例如：安装失败、配置错误、运行异常），或者您有新的应用收录请求，欢迎通过 [**GitHub Issues**](https://github.com/Coinsinical/appstore/issues) 提交反馈。

**在提交 Issue 之前，请：**

1.  **搜索** 现有的 Issues，确保您的问题尚未被报告。
2.  **检查** 问题的根源。如果是应用 *本身* 的 Bug（而非 1Panel 的安装或配置问题），建议您优先向该应用的**原始项目仓库**反馈。

**提交 Issue 时，请尽量提供：**

* **[应用名称]**: 您遇到问题的应用。
* **[问题描述]**: 清晰描述遇到了什么问题。
* **[复现步骤]**: 如何重现这个问题。
* **[环境信息]**: 您的 1Panel 版本、操作系统等。

---
## 🤝 如何贡献

我们热烈欢迎您为本仓库贡献新的应用或优化版本！请遵循以下流程：

1.  **Fork** 本仓库。
2.  请确保您的应用符合 1Panel 的应用打包规范，并已在您自己的环境中**充分测试**。
3.  在 `apps` 目录下创建您的应用文件夹。
4.  **提交 Pull Request**，并请在 PR 描述中详细说明应用的功能、来源以及测试情况。

我们会在收到 PR 后尽快进行 Review！

---

## ⚖️ 许可证 (License)

本仓库（指相关维护脚本）采用 [MIT License](LICENSE) 授权。

*注意：仓库中收录的各个独立应用均遵循其各自的开源许可证。*
