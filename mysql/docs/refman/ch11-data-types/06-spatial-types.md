# 第 11 章 数据类型 · 空间数据类型

> 对应 SQL：[`sql/refman/ch11-data-types/06-spatial-types.sql`](../../../sql/refman/ch11-data-types/06-spatial-types.sql)

---

## 11.4 空间数据类型

[开放地理空间联盟](http://www.opengeospatial.org)(OGC) 是一个由 250 多家公司、机构和大学组成的国际联盟，参与开发公开可用的概念解决方案，这些解决方案可用于管理空间数据的各种应用程序

      。

      Open Geospatial Consortium 发布了
      *OpenGIS® Implementation Standard for Geographic information - Simple feature access - Part 2: SQL option*，该文档提出了几种扩展 SQL RDBMS 以支持空间数据的概念性方法。该规范可从 OGC 网站
      [http://www.opengeospatial.org/standards/sfs](http://www.opengeospatial.org/standards/sfs)获得。

      遵循 OGC 规范，MySQL 将空间扩展作为**SQL with Geometry Types**环境的一个子集来实​​现。该术语指的是已使用一组几何类型进行扩展的 SQL 环境。几何值 SQL 列被实现为具有几何类型的列。该规范描述了一组 SQL 几何类型，以及这些类型上用于创建和分析几何值的函数。

      MySQL 空间扩展支持地理特征的生成、存储和分析：

- 表示空间值的数据类型
- 操作空间值的函数
- 用于改进对空间列的访问时间的空间索引

      空间数据类型和函数可用于
      `MyISAM`、
       `InnoDB`、
      `NDB`和
      `ARCHIVE`表。用于索引空间列，`MyISAM`同时`InnoDB`
      支持`SPATIAL`和非`SPATIAL`索引。其他存储引擎支持非`SPATIAL`索引，如
      第 13.1.15 节“CREATE INDEX 语句”中所述。

**地理特征**是世界上任何具有位置的事物
      。一个特征可以是：

- 一个实体。例如，一座山，一座池塘，一座城市。
- 空间。例如，城镇区，热带地区。
- 一个可定义的位置。例如，十字路口，作为两条街道相交的特定位置。

      一些文档使用术语**地理空间特征**来指代地理特征。

      **几何**是表示地理特征的另一个词。最初，
      **几何**这个词的意思是测量地球。另一个含义来自制图学，指的是制图师用来绘制世界地图的几何特征。

      此处的讨论将这些术语视为同义词：
      **地理特征**、
      **地理空间特征**、
      **特征**或
      **几何**。最常用的术语是**几何**，定义为
      *一个点或一组点，代表世界上任何具有位置的事物*。

      以下材料涵盖了这些主题：

- MySQL 模型中实现的空间数据类型
- OpenGIS 几何模型中空间扩展的基础
- 表示空间数据的数据格式
- 如何在 MySQL 中使用空间数据
- 空间数据索引的使用
- MySQL 与 OpenGIS 规范的差异

      有关对空间数据进行操作的函数的信息，请参阅
      第 12.17 节，“空间分析函数”。

### 其他资源

      这些标准对于空间操作的 MySQL 实现很重要：

- SQL/MM 第 3 部分：空间。
- Open Geospatial Consortium发布了OpenGIS® Implementation Standard for Geographic information ， 该文档提出了几种扩展 SQL RDBMS 以支持空间数据的概念性方法。具体请参见简单功能访问 - 第 1 部分：通用架构和简单功能访问 - 第 2 部分：SQL 选项。开放地理空间联盟 (OGC) 维护着一个网站，网址为 http://www.opengeospatial.org/。该规范可在 http://www.opengeospatial.org/standards/sfs获得。它包含与此处材料相关的附加信息。
- 空间参考系统(SRS) 定义的语法基于 OpenGIS 实施规范中定义的语法：坐标转换服务，修订版 1.00，OGC 01-009，2001 年 1 月 12 日，第 7.2 节。该规范可从 http://www.opengeospatial.org/standards/ct获得。有关在 MySQL 中实现的 SRS 定义中与该规范的差异，请参阅 第 13.1.19 节，“CREATE SPATIAL REFERENCE SYSTEM 语句”。

      如果您对使用 MySQL 的空间扩展有疑问或疑虑，可以在 GIS 论坛中进行讨论：
       [https](https://forums.mysql.com/list.php?23) ://forums.mysql.com/list.php?23 。

---

[← 返回 第 11 章 数据类型 索引](00-index.md) · [← 返回总索引](../00-index.md)
