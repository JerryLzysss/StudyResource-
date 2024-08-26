# npm操作
NPM的全称是Node Package Manager，是一个NodeJS包管理和分发工具，已经成为了非官方的发布Node模块（包）的标准。
## npm 初始化及指令
npm -v查看版本
npm init -y 或者npm init --yes 创建package.json
package json是包的配置文件
npm install或者npm i 命令安装包
node_modules 存放下载包
package-lock.json锁定包
npm全局安装
npm i -g nodemon
全局安装可以在任意位置运行
不受工作目录位置影响
npm root -g查看全局安装包位置
npm i 可以依据package.json安装依赖
npm  i <包名与版本号> 安装相关版本的包
npm remove uniq 局部删除
npm remove -g nodemon 全局删除
npm run 自动向上级查找
npm start 启动项目
npm login填写用户信息
npm publish更新包
npm unpublish 删除包
## require导入
在当前文件夹下node_modules找同名文件夹
上级目录寻找直至找到磁盘

## 生产依赖与开发依赖
npm i -S uniq -S等效于-save
包信息保存于package.json的dependencies属性
npm i -D less -D等效于--save-dev
报信息保存于package.json中devdependencies属性

## 部分常用npm的拓展 
### cnpm是淘宝构建npmjs.com的完整影像
npm install -g cnpm --registry==https://registry.npmmirror.co
### yarn 是javascript包管理工具
npm i -g yarn 安装yarn
### nvm nodejs管理工具
https://github.com/coreybutler/nvm-windows/releases
选择nvm-setup.exe安装
nvm list available
nvm list
nvm install 18.12.1
nvm install latest
nvm uninstall 18.12.1
nvm use 18.12.1