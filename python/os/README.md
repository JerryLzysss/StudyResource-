# os — 标准库笔记

本目录演示 Python 内置 [`os`](https://docs.python.org/zh-cn/3/library/os.html) 模块的常用操作。

上级总览：[../README.md](../README.md)

## 文件索引

| 文件 | 说明 |
|------|------|
| [os.py](os.py) | 当前目录、列目录、环境变量等常用 API 示例 |

## 示例覆盖要点

脚本中以注释或代码演示：

| API | 作用 |
|-----|------|
| `os.getcwd()` | 获取当前工作目录 |
| `os.chdir(path)` | 切换工作目录 |
| `os.listdir(path)` | 列出目录内容 |
| `os.mkdir(path)` | 创建目录 |
| `os.rmdir(path)` | 删除空目录 |
| `os.remove(path)` | 删除文件 |
| `os.rename(src, dst)` | 重命名文件或目录 |
| `os.getenv(key)` | 读取环境变量 |
| `os.system(cmd)` | 执行系统命令 |

## 运行说明

```bash
cd os
python os.py
```

注意：涉及创建/删除/重命名目录或文件的 API 若取消注释执行，请确认路径，避免误删。Windows 上部分环境变量名可能与 Unix 不同（例如用户目录更常见为 `USERPROFILE`）。
