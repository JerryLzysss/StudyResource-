[TOC]
# Git 分区

## 工作区
开发人员当前正在开发的项目工作空间，是我们肉眼可见的。 Git系统不会管工作区中任何文件内容的修改，仅监控暂存区。
## 暂存区
Git系统内部，管理开发人员项目中临时修改文件的区域，用于临时存放文件的改动，它会存放上一次开发人员 git add 添加之后的数据。 在后续继续向版本库提交更新代码时，git会比较暂存区与工作区间的差异，给予相关操作提示。
## 版本库
类似仓库，存储很多配置信息、日志信息、以及文件各种修改后的最终版本信息。


# Git 使用

## 1.创建GIT账号(github/gitlab/gitee)
使用github需要获取token(新规定吧)

## 2.初始化仓库
打开对应文件目录，使用``` git init ```

## 3.添加文件
在目录中使用 ``` git add ./```或者``` git add <文件>```添加到暂存区

## 4.提交备注
``` git commit -m "备注" ``` 对所有在暂存区的文件添加该备注

## 5.设置 git地址
```
git remote -v 查看当前git地址
git remote set-url "库名" "git地址"
例如 git remote origin "xxx@github.com"
表示的是将地址设置设置仓库origin地址为xxx@github.com
```

## 6.提交与拉取命令
```
git pull 拉取代码(如果版本不一致需要先拉取)
git push "库名" "分支名"
例如 git push origins main是将代码拉取地址为
origins的main分支上
```

## 7.其他的git命令
```
git branch 查看本地当前所有分支
git status 查看当前状态
git commit 提交
git branch -a 查看所有分支
git branch -r 查看本地所有分支
git remote show origin 显示origin库里的资源
git checkout --track origin/dev 切换远程dev分支
git branch -D master 删除master分支
git checkout -b dev 新建dev分支
git checkout dev 切换到本地dev分支
git remote show 查看远程库
git remote -v 查看当前git地址
git rm 文件名 从git中删除指定文件
git rm 文件夹 删除文件夹
git commit -v 查看commit的差异
git ls -files 查看以及提交的
git diff 查看尚未暂存的更新
git stash push 将文件放到一个临时空间
git stash pop 将文件推出
git fetch 从远程获取最新版本
git merge origin/dev 将分支dev与当前分支合并.



# Git 错误解析
Q:fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.
A:重新输入一次地址
``` git remote add <地址> ```

Q:error: src refspec main does not match any
error: failed to push some refs to 'github地址'
A:不存在该分支，重新选择分支即可。

Q:fatal: unable to access '<地址>': Failed to connect to github.com port 443: Timed out
A:可以尝试取消代理（也有可能是太慢了)
``` git config --global --unset http.proxy```

Q:Logon failed, use ctrl+c to cancel basic credential prompt.
remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for <地址>
A:github取消了使用密码登录的方式，需要配置令牌
```
1.点击个人页面的 settings
2.在左侧寻找到最下面的 Developer settings
3.点击 Personal access tokens(个人访问令牌)
4.点击 Generate new token
5.设置 token 信息
6.根据所需过期时间，建议设置成永远，以免麻烦，建议所有选项都选上
7.点击 Generate token 生成令牌
8.得到生成的令牌
9.应用令牌
10.修改现有的 url
git remote set-url origin  https://<your_token>@github.com/<USERNAME>/<REPO>.git
将<your_token>换成你自己得到的令牌。<USERNAME>是你自己github的用户名，<REPO>是你的项目名称
换成你自己得到的令牌。是你自己github的用户名，`是你的项目名称
然后再次执行 pull push 操作
```


Q:生成密钥的方式
A：1.首先设置用户名与邮箱..
```
git config --list 查看git config信息
git config --global --edit 修改全局config(vim模式)
git config user.name "username" 添加内容user.name,值为username
```

2.设置生成密钥
ssh-keygen -t rsa -C "邮箱"

3.在主机中寻找生成的密钥信息
C:\Users(用户)\用户名\.ssh\id_rsa.pub

4.打开个人信息设置
个人头像/setting/SSH and GPG keys
将内容复制进入即可完成

Git报错：Updates were rejected because the tip of your current branch is behind