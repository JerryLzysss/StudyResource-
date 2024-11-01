
# Electron 打包程序
Forge地址:https://www.electronforge.io/

# Electron Forge
Electron 的核心模块中没有捆绑任何用于打包或分发文件的工具。 如果您在开发模式下完成了一个 Electron 应用，需要使用额外的工具来打包应用程序 (也称为可分发文件) 并分发给用户 。 可分发文件可以是安装程序 (例如 Windows 上的 MSI) 或者绿色软件 (例如 macOS 上的 .app 文件)。

Electron Forge 是一个处理 Electron 应用程序打包与分发的一体化工具。 在工具底层，它将许多现有的 Electron 工具 (例如 @electron/packager、 @electron/osx-sign、electron-winstaller 等) 组合到一起，因此您不必费心处理不同系统的打包工作。
# 导入Forge
```
npm install --save-dev @electron-forge/cli
npx electron-forge import
```
您还应该注意到您的 package.json 现在安装了更多的包 在 devDependencies 下，以及一个导出配置的新 forge.config.js 文件 目的。 您应该在预填充的配置中看到多个makers（生成可分发应用程序包的包），每个目标平台一个。

# 创建可分发版本
要创建可分发文件，请使用项目中的 make 脚本，该脚本最终运行了 electron-forge make 命令。
`npm run make`
该 make 命令包含两步：
它将首先运行 electron-forge package ，把您的应用程序代码与 Electron 二进制包结合起来。 完成打包的代码将会被生成到一个特定的文件夹中。
然后它将使用这个文件夹为每个 maker 配置生成一个可分发文件。
在脚本运行后，您应该看到一个 out 文件夹，其中包括可分发文件与一个包含其源码的文件夹。
自定义图标可以查看Forge文档https://www.electronforge.io/guides/create-and-add-icons
# 代码签名
代码签名是一种可用于证明桌面应用程序是由已知来源创建的安全技术。 Windows 和 macOS 拥有其特定的代码签名系统，这将使用户难以下载或启动未签名的应用程序。
在 macOS 上，代码签名是在应用程序打包时完成的。 而在 Windows 中，则是对可分发文件进行签名操作。 如果您已经拥有适用于 Windows 和 macOS 的代码签名证书，可以在 Forge 配置中设置您的凭据
```
---windows---
module.exports = {
  // ...
  makers: [
    {
      name: '@electron-forge/maker-squirrel',
      config: {
        certificateFile: './cert.pfx',
        certificatePassword: process.env.CERTIFICATE_PASSWORD
      }
    }
  ]
  // ...
}
```