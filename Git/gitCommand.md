# 常用 Git 指令速查

## 配置

```bash
git config --list                          # 查看当前配置
git config --global --edit                 # 编辑全局配置（vim）
git config --global user.name "用户名"     # 设置用户名
git config --global user.email "邮箱"      # 设置邮箱
git config --global --unset http.proxy     # 取消 HTTP 代理
git config --global http.sslVerify false   # 关闭 SSL 校验（不推荐）
```

## 仓库初始化与克隆

```bash
git init                                   # 在当前目录初始化仓库
git clone <仓库地址>                       # 克隆远程仓库
git clone <仓库地址> <本地目录名>           # 克隆到指定目录
```

## 查看状态与差异

```bash
git status                                 # 查看工作区 / 暂存区状态
git diff                                   # 查看工作区未暂存的改动
git diff --staged                          # 查看已暂存、未提交的改动
git log                                    # 查看提交历史
git log --oneline --graph --all            # 简洁图形化提交历史
git show <commit>                          # 查看某次提交详情
git ls-files                               # 查看已被 Git 跟踪的文件
```

## 暂存与提交

```bash
git add <文件>                             # 将指定文件加入暂存区
git add .                                  # 将当前目录所有改动加入暂存区
git commit -m "备注"                       # 提交暂存区内容
git commit -v                              # 提交时查看差异
git commit --amend -m "新备注"             # 修改最近一次提交说明（慎用）
git rm <文件>                              # 从 Git 中删除文件并暂存
git rm -r <文件夹>                         # 删除文件夹
git restore <文件>                         # 丢弃工作区改动
git restore --staged <文件>                # 取消暂存（保留工作区改动）
```

## 远程仓库

```bash
git remote -v                              # 查看远程地址
git remote show                            # 查看远程库列表
git remote show origin                     # 查看 origin 详情
git remote add <库名> <地址>               # 添加远程仓库
git remote set-url <库名> <地址>           # 修改远程地址
git fetch                                  # 拉取远程更新（不合并）
git fetch origin                           # 拉取指定远程
git pull                                   # 拉取并合并到当前分支
git pull origin <分支名>                   # 拉取指定远程分支
git pull --rebase origin <分支名>          # 以 rebase 方式拉取合并
git pull --allow-unrelated-histories       # 允许合并不相关历史
git push <库名> <分支名>                   # 推送到远程
git push -u origin main                    # 推送并设置上游分支
git push -f origin main                    # 强制推送（慎用）
```

## 分支

```bash
git branch                                 # 查看本地分支
git branch -a                              # 查看所有分支（含远程）
git branch -r                              # 查看远程分支
git branch <分支名>                        # 新建分支（不切换）
git branch -M main                         # 重命名当前分支为 main
git branch -d <分支名>                     # 删除已合并分支
git branch -D <分支名>                     # 强制删除分支
git checkout <分支名>                      # 切换分支
git checkout -b <分支名>                   # 新建并切换分支
git checkout --track origin/dev            # 跟踪并切换远程分支
git switch <分支名>                        # 切换分支（新写法）
git switch -c <分支名>                     # 新建并切换分支（新写法）
git merge <分支名>                         # 将指定分支合并到当前分支
git merge origin/dev                       # 合并远程 origin/dev
```

## 暂存工作（stash）

```bash
git stash                                  # 暂存当前工作区改动
git stash push -m "说明"                   # 带说明暂存
git stash list                             # 查看暂存列表
git stash pop                              # 恢复最近一次暂存并删除记录
git stash apply                            # 恢复最近一次暂存但保留记录
git stash drop                             # 删除最近一次暂存
git stash clear                            # 清空所有暂存
```

## 撤销与回退

```bash
git reset HEAD~1                           # 撤销最近一次提交（保留改动）
git reset --soft HEAD~1                    # 撤销提交，改动留在暂存区
git reset --hard HEAD~1                    # 撤销提交并丢弃改动（危险）
git reset --hard <commit>                  # 回退到指定提交（危险）
git revert <commit>                        # 生成新提交来撤销某次提交（更安全）
git checkout -- <文件>                     # 丢弃某文件工作区改动（旧写法）
```

## SSH 密钥（常用配套）

```bash
ssh-keygen -t rsa -C "邮箱"                # 生成 SSH 密钥
# 公钥一般在：C:\Users\<用户名>\.ssh\id_rsa.pub
# 将公钥内容添加到 GitHub/GitLab：Settings → SSH and GPG keys
```

## 日常工作流示例

```bash
# 1. 拉取最新代码
git pull origin main

# 2. 新建功能分支
git checkout -b feature/xxx

# 3. 开发后提交
git add .
git commit -m "完成 xxx 功能"

# 4. 推送分支
git push -u origin feature/xxx

# 5. 与主分支合并前先同步
git checkout main
git pull origin main
git checkout feature/xxx
git merge main

# 6. 暂存未完成改动、切分支应急
git stash
git checkout main
# ... 处理紧急事务 ...
git checkout feature/xxx
git stash pop
```
