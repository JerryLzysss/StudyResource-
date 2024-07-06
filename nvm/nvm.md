[TOC]
# 为什么需要使用nvm

解决多个Node版本兼容的问题，使用新版本的node与旧版本的Node问题

# 安装nvm
<https://github.com/coreybutler/nvm-windows/releases/download/1.1.10/nvm-setup.zip> 免配置版本

# nvm指令
```
nvm version => 查看nvm版本号
nvm is available=> 查看可以使用的nodejs列表
nvm 常用指令
nvm arch
nvm install xxx
nvm on
nvm off
例如nvm install 16.20.2
```

# 使用对应nvm

nvm use xxx

# npm管理问题

一般在安装node的时候，npm也会自动一起安装的。由于nvm可以管理多个版本的node，如果每次添加一个node版本都要安装一堆npm包就烦锁了，所以将npm全局共享出来，只需全局（在安装模块时 npm i xxx -g ）加上-g， 就可以让各个版本的node共用就OK了。

当然npm全局安装目录也是可以修改的：使用：npm  config set prefix "要设置的路径" 命令就可以修改！

用 npm root -g 命令，可以查看全局默认npm包的存储位置。

然后将npm包的路径添加到用户环境变量中，就实现npm全局共享啦！具体步骤如下图提示以操作即可！

