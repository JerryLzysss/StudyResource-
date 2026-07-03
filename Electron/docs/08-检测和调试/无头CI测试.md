# 无头 CI 测试

> 官方文档：[Testing on Headless CI | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/testing-on-headless-ci)

## 概述

在 Travis、Jenkins、GitHub Actions 等 CI 环境中运行 Electron 测试需要额外配置。

## Linux CI 依赖

```sh
sudo apt-get install -y \
  libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 \
  xvfb libatspi2.0-0 libdrm2 libgbm1
```

## 使用 xvfb

```sh
xvfb-run --auto-servernum npm test
```

## GitHub Actions 示例

```yaml
- name: Run tests
  uses: coactions/setup-xvfb@v1
  with:
    run: npm test
```

## 跳过二进制下载

在 CI 中安装依赖时设置：

```sh
ELECTRON_SKIP_BINARY_DOWNLOAD=1 npm install
```
