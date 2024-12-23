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
先添加仓库，如果有需要在使用修改!!!
git remote add "库名" "git地址" 添加当前地址
git remote -v 查看当前git地址
git remote set-url "库名" "git地址" 修改当前git地址
例如 git remote origin "xxx@github.com"
表示的是将地址设置设置仓库origin地址为xxx@github.com
```
## 6.（如果是初次使用) 设置分支
```
git branch -M main 将本地分支重命名为 main。
```
(由于默认情况下git会将master作为本地分支)
这个命令通常用于将本地分支 main 与远程分支 main 保持一致，或者在创建新的本地分支时，需要将本地分支名称设置为 main。

## 7.提交与拉取命令
```
git pull 拉取代码(如果版本不一致需要先拉取)
git push "库名" "分支名"
例如 git push origins main是将代码拉取地址为
origins的main分支上
```

## 8.其他的git命令
```
git branch 查看本地当前所有分支
git status 查看当前状态
git commit 提交
git branch -a 查看所有分支
git branch -r 查看本地所有分支
git remote show origin 显示origin库里的资源
git checkout --track origin/dev 切换远程dev分支
git branch -D master 删除master分支
git branch <branch_name> 添加新分支(不切换分支)
git checkout -b <branch_name>添加新分支(切换分支)
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
```


# Git 错误解析
## 1.fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.
A:重新输入一次地址
``` git remote add <地址> ```

## 2.error: src refspec main does not match any
error: failed to push some refs to 'github地址'
A:不存在该分支，重新选择分支即可。还有就是可能没有设置该地址。

## 3.fatal: unable to access '<地址>': Failed to connect to github.com port 443: Timed out
A:可以尝试取消代理（也有可能是太慢了)
``` git config --global --unset http.proxy```

## 4.Logon failed, use ctrl+c to cancel basic credential prompt.
remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for <地址>
A:github取消了使用密码登录的方式，需要配置令牌
```
1.点击个人页面的 settings<br>
2.在左侧寻找到最下面的 Developer settings<br>
3.点击 Personal access tokens(个人访问令牌)<br>
4.点击 Generate new token<br>
5.设置 token 信息<br>
6.根据所需过期时间，建议设置成永远，以免麻烦，建议所有选项都选上<br>
7.点击 Generate token 生成令牌<br>
8.得到生成的令牌<br>
9.应用令牌<br>
10.修改现有的 url<br>
git remote set-url origin  https://<your_token>@github.com/<USERNAME>/<REPO>.git
将<your_token>换成你自己得到的令牌。<USERNAME>是你自己github的用户名，<REPO>是你的项目名称
换成你自己得到的令牌。是你自己github的用户名，`是你的项目名称
然后再次执行 pull push 操作
```


## 5.生成密钥的方式
A：1.首先设置用户名与邮箱..
```
git config --list 查看git config信息
git config --global --edit 修改全局config(vim模式)
git config user.name "username" 添加内容user.name,值
为username
```
2.设置生成密钥
ssh-keygen -t rsa -C "邮箱"

3.在主机中寻找生成的密钥信息
C:\Users(用户)\用户名\.ssh\id_rsa.pub

4.打开个人信息设置
个人头像/setting/SSH and GPG keys
将内容复制进入即可完成

## 6.Git报错：Updates were rejected because the tip of your current branch is behind
A:你的当前分支的最新提交落后于远程分支的最新提交。本地仓库版本落后于远程仓库。为了解决这个问题，你需要先将远程分支的更改合并到本地分支，然后再次尝试推送你的更改.
有以下几种解决的方法:
1. 强制推送 
```git push -f origin main(强制推送到main分支上)```

2.```git pull origin --rebase 合并分支到一条分支上 ```
解释:其原理类似于git merge,而git merge是合并分支，例如A与B共同实现一个项目，则是把A的内容与B的内容进行合并生成一个新的基点，git rebase则是将当前的分支A转移到分支B后，以分支B为基点进行内容合并.

## 7.error: pathspec 'main' did not match any file(s) known to git
A:需要确认是否存在该分支，如首次创建的时候，github上显示为main分支，而实际上本地只有master分支，因此需要对此重命名，亦或者是通过创建main分支后转移为main分支.

## 8.error: Cannot delete branch 'test' checked out 
A:确认是否位于该分支上，切换到其他分支即可。

## 9.bash: Author: command not found
```
Please tell me who you are.
Run
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
to set your account's default identity.
Omit --global to set the identity only in this repository.
fatal: unable to auto-detect email address (got '电脑名字+.(none)')
```
A:一眼可见，需要输入用户名字与邮箱等等信息在电脑上.
指令就是git config --global xxx "xxx"

## 10.Q:unable to get local issuer certificate.
A:git config --global http.sslVerify false
第一种方法:使用Git的配置选项来禁用SSL证书验证（不推荐，因为这会降低安全性）：
安装或更新本地的CA证书包。在Linux系统中，你可以使用包管理器来安装ca-certificates包。
第二种方法:添加证书(略)

## 11.error: failed to push some refs to 'xxx.git'
```
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```
方式1：pull
先去将远程仓库的同步到本地，再push
```
git pull origin master
git push origin master
```
方式2：rebase
①如果依然遇到这个警告，说明你之前commit过了，需要通过–rebase方式将本地的提交暂存起来。同时从远程仓库的master分支拉取最新的提交。
```git pull --rebase origin master```
## 12.error:git pull fatal: refusing to merge unrelated histories
这个错误发生在尝试使用git pull命令合并两个独立的仓库时。Git拒绝合并没有共同祖先的两个分支的历史记录，因为这样的合并可能会导致数据丢失。自Git 2.9版本以后，默认情况下，如果尝试合并两个没有共同历史的分支，Git会拒绝进行合并，并提示这个错误信息。
解决方法：
为了解决这个问题，你可以使用--allow-unrelated-histories选项来允许合并不相关的历史。执行以下命令：
```git pull --allow-unrelated-histories```

## 13.与其他人合并代码
方法一:(简单粗暴) git pull origin develop =>获取当前主分支
注意:如果没有提交当前的代码会提示出要求先提交代码，可以先上传到自己的分支(git push 自己的分支)
git push => git pull origin develop => git push 即可.
也就是说先将代码提交到自己分支，然后拉取主分支中其他人写的代码，然后合并代码即可.
方法二:(暂存) git stash =>将自己的代码存起来
git stash => git pull origin develop => git stash pop => merge
暂存起自己的代码，此时就与dev分支的代码相同，再去拉取dev分支代码后合并他人的代码，之后再将自己暂存的代码pop出来后与当前代码进行合并.

