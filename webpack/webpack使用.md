# webpack使用步骤
1.使用步骤
目录分析
webpack_code #项目根目录（所有指令必须在这个目录执行）
|_src项目源码目录
	|_js文件目录
	|
	|
	|_main.js项目主文件

2.下载依赖
打开终端，来到项目根目录，运行以下指令
3.初始化package.json
npm init -y
此时会生成一个基础的package.json文件
需要注意的是package.json中name字段不能叫做webpack.
4.下载依赖
npm i webpack webpack -cli -D

5.启用webpack
开发模式
npx webpack ./src/main.js --mode=development
生产模式
npx webpack ./src/main.js --mode=production

6.观察输出文件
默认webpack会将文件打包输出到dist目录，查看dist目录情况就好了

7.webpack本身功能比较少，智能处理js资源，一旦遇到其他css等资源就会报错。