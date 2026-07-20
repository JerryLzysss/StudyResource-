# String

## 概述

`String` 类代表字符串。

## 特点

- 双引号 `"..."` 形式的字面量都是 `String` 对象
- 字符串内容不可变，创建之后不能更改

## 实现原理

- JDK 8 及之前：底层多为 `final char[]`
- JDK 9 及之后：底层多为 `final byte[]`（节省空间）

## 常用方法

### 创建

- `String()`：无参构造
- `String(String original)`：根据已有字符串构建
- `String(char[] value)`：根据 char 数组构建
- `String(byte[] value)`：根据 byte 数组构建
- `String(char[] value, int offset, int count)`：将 char 数组一部分转为字符串
- `String(byte[] bytes, int offset, int length)`：将 byte 数组一部分转为字符串
  - `offset`：起始索引
  - `length` / `count`：长度

### 拼接与常量池

- 等号右边若是纯字面量拼接，编译期可能优化进常量池
- 若涉及变量拼接，通常会产生新对象

### 比较

| 方式 | 含义 |
|------|------|
| `==` | 比较引用是否指向同一对象 |
| `equals()` | 比较字符串内容 |
| `equalsIgnoreCase()` | 忽略大小写比较内容 |

### 获取

- `length()`：长度
- `concat(String)`：拼接
- `charAt(int)`：获取指定索引处的字符
- `indexOf(String)`：第一次出现的位置
- `substring(int)` / `substring(int, int)`：截取子串

### 转换

- `toCharArray()`：转为 char 数组
- `getBytes()` / `getBytes("UTF-8")`：转为字节
- `replace(c1, c2)`：替换

### 其他

- `split(regex)`：按规则分割
- `contains()`：是否包含
- `endsWith()` / `startsWith()`：判断结尾/开头
- `toLowerCase()` / `toUpperCase()`：大小写转换
- `trim()`：去掉两端空白

---

# StringBuilder

概述：可变字符序列，API 与 `StringBuffer` 类似；**非线程安全**，单线程下效率更高。

## 作用

频繁拼接时，`String` 每次拼接可能产生新对象；`StringBuilder` 在可变缓冲区中追加，减少临时对象。

## 特点

- 底层有可变缓冲区，默认容量通常为 16
- 容量不足时会扩容（常见策略约为原容量的 2 倍再加 2）

## 常用方法

- `StringBuilder()` / `StringBuilder(String str)`
- `append(str)`：末尾追加
- `reverse()`：反转
- `toString()`：转为 `String`

## StringBuffer

用法与 `StringBuilder` 基本一致。

- 效率：通常 `StringBuilder` 更高
- 线程安全：`StringBuffer` 的方法带同步，更适合多线程场景
