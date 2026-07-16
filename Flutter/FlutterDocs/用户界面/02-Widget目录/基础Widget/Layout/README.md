# Layout

> 官方文档：[Layout](https://docs.flutter.cn/ui/widgets/layout)
> 内容来源：html
> 抓取时间：2026-07-10

---

Arrange other widgets columns, rows, grids, and many other layouts.

## Single-child layout widgets

                [Align

                    A widget that aligns its child within itself and optionally sizes itself based on the child's size.](https://api.flutter-io.cn/flutter/widgets/Align-class.html)
                [AspectRatio
                  A widget that attempts to size the child to a specific aspect ratio.](https://api.flutter-io.cn/flutter/widgets/AspectRatio-class.html)
                [Abc

                  Baseline
                  Container that positions its child according to the child's baseline.](https://api.flutter-io.cn/flutter/widgets/Baseline-class.html)
                [Center
                  Alignment block that centers its child within itself.](https://api.flutter-io.cn/flutter/widgets/Center-class.html)
                [ConstrainedBox
                  A widget that imposes additional constraints on its child.](https://api.flutter-io.cn/flutter/widgets/ConstrainedBox-class.html)
                [Container
                  A convenience widget that combines common painting, positioning, and sizing widgets.](https://api.flutter-io.cn/flutter/widgets/Container-class.html)
                [CustomSingleChildLayout

A widget that defers the layout of its single child to a delegate.](https://api.flutter-io.cn/flutter/widgets/CustomSingleChildLayout-class.html)
                [Expanded

A widget that expands a child of a Row, Column, or Flex.](https://api.flutter-io.cn/flutter/widgets/Expanded-class.html)
                [FittedBox

Scales and positions its child within itself according to fit.](https://api.flutter-io.cn/flutter/widgets/FittedBox-class.html)
                [FractionallySizedBox

                      A widget that sizes its child to a fraction of the total available space. For more details about the layout algorithm, see RenderFractionallySizedOverflowBox.](https://api.flutter-io.cn/flutter/widgets/FractionallySizedBox-class.html)
                [IntrinsicHeight

A widget that sizes its child to the child's intrinsic height.](https://api.flutter-io.cn/flutter/widgets/IntrinsicHeight-class.html)
                [IntrinsicWidth

A widget that sizes its child to the child's intrinsic width.](https://api.flutter-io.cn/flutter/widgets/IntrinsicWidth-class.html)
                [LimitedBox

A box that limits its size only when it's unconstrained.](https://api.flutter-io.cn/flutter/widgets/LimitedBox-class.html)
                [Offstage

                      A widget that lays the child out as if it was in the tree, but without painting anything, without making the child available for hit...](https://api.flutter-io.cn/flutter/widgets/Offstage-class.html)
                [OverflowBox

                      A widget that imposes different constraints on its child than it gets from its parent, possibly allowing the child to overflow the parent.](https://api.flutter-io.cn/flutter/widgets/OverflowBox-class.html)
                [Padding
                  A widget that insets its child by the given padding.](https://api.flutter-io.cn/flutter/widgets/Padding-class.html)
                [SizedBox

                      A box with a specified size. If given a child, this widget forces its child to have a specific width and/or height (assuming values are...](https://api.flutter-io.cn/flutter/widgets/SizedBox-class.html)
                [SizedOverflowBox

                      A widget that is a specific size but passes its original constraints through to its child, which will probably overflow.](https://api.flutter-io.cn/flutter/widgets/SizedOverflowBox-class.html)
                [Transform

A widget that applies a transformation before painting its child.](https://api.flutter-io.cn/flutter/widgets/Transform-class.html)

## Multi-child layout widgets

                [Column

Layout a list of child widgets in the vertical direction.](https://api.flutter-io.cn/flutter/widgets/Column-class.html)
                [CustomMultiChildLayout

A widget that uses a delegate to size and position multiple children.](https://api.flutter-io.cn/flutter/widgets/CustomMultiChildLayout-class.html)
                [CarouselView

                      A Material carousel widget that presents a scrollable list of items, each of which can dynamically change size based on the chosen layout.](https://main-api.flutter-io.cn/flutter/material/CarouselView-class.html)
                [Flow

A widget that implements the flow layout algorithm.](https://api.flutter-io.cn/flutter/widgets/Flow-class.html)
                [GridView

                      A grid list consists of a repeated pattern of cells arrayed in a vertical and horizontal layout. The GridView widget implements this component.](https://api.flutter-io.cn/flutter/widgets/GridView-class.html)
                [IndexedStack

A Stack that shows a single child from a list of children.](https://api.flutter-io.cn/flutter/widgets/IndexedStack-class.html)
                [LayoutBuilder

Builds a widget tree that can depend on the parent widget's size.](https://api.flutter-io.cn/flutter/widgets/LayoutBuilder-class.html)
                [ListBody

                      A widget that arranges its children sequentially along a given axis, forcing them to the dimension of the parent in the other axis.](https://api.flutter-io.cn/flutter/widgets/ListBody-class.html)
                [ListView

                      A scrollable, linear list of widgets. ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction....](https://api.flutter-io.cn/flutter/widgets/ListView-class.html)
                [OverflowBar

                      A widget that lays out its children in a row unless they "overflow" the available horizontal space, in which case it lays them out in...](https://api.flutter-io.cn/flutter/widgets/OverflowBar-class.html)
                [Row

Layout a list of child widgets in the horizontal direction.](https://api.flutter-io.cn/flutter/widgets/Row-class.html)
                [Stack

                      This class is useful if you want to overlap several children in a simple way, for example having some text and an image, overlaid with...](https://api.flutter-io.cn/flutter/widgets/Stack-class.html)
                [Table

Displays child widgets in rows and columns.](https://api.flutter-io.cn/flutter/widgets/Table-class.html)
                [Wrap

A widget that displays its children in multiple horizontal or vertical runs.](https://api.flutter-io.cn/flutter/widgets/Wrap-class.html)

## Sliver widgets

                [CupertinoSliverNavigationBar

A navigation bar with iOS-11-style large titles using slivers.](https://api.flutter-io.cn/flutter/cupertino/CupertinoSliverNavigationBar-class.html)
                [CupertinoSliverRefreshControl

A sliver widget implementing the iOS-style pull to refresh content control.](https://api.flutter-io.cn/flutter/cupertino/CupertinoSliverRefreshControl-class.html)
                [CustomScrollView

A ScrollView that creates custom scroll effects using slivers.](https://api.flutter-io.cn/flutter/widgets/CustomScrollView-class.html)
                [SliverAppBar

A material design app bar that integrates with a CustomScrollView.](https://api.flutter-io.cn/flutter/material/SliverAppBar-class.html)
                [SliverChildBuilderDelegate

A delegate that supplies children for slivers using a builder callback.](https://api.flutter-io.cn/flutter/widgets/SliverChildBuilderDelegate-class.html)
                [SliverChildListDelegate

A delegate that supplies children for slivers using an explicit list.](https://api.flutter-io.cn/flutter/widgets/SliverChildListDelegate-class.html)
                [SliverFillRemaining

A sliver that contains a single box child that fills the remaining space in the viewport.](https://api.flutter-io.cn/flutter/widgets/SliverFillRemaining-class.html)
                [SliverFixedExtentList

A sliver that places multiple box children with the same main axis extent in a linear array.](https://api.flutter-io.cn/flutter/widgets/SliverFixedExtentList-class.html)
                [SliverGrid

A sliver that places multiple box children in a two dimensional arrangement.](https://api.flutter-io.cn/flutter/widgets/SliverGrid-class.html)
                [SliverList

A sliver that places multiple box children in a linear array along the main axis.](https://api.flutter-io.cn/flutter/widgets/SliverList-class.html)
                [SliverPadding

A sliver that applies padding on each side of another sliver.](https://api.flutter-io.cn/flutter/widgets/SliverPadding-class.html)
                [SliverPersistentHeader

                      A sliver whose size varies when the sliver is scrolled to the edge of the viewport opposite the sliver's GrowthDirection.](https://api.flutter-io.cn/flutter/widgets/SliverPersistentHeader-class.html)
                [SliverToBoxAdapter

A sliver that contains a single box widget.](https://api.flutter-io.cn/flutter/widgets/SliverToBoxAdapter-class.html)

更多 widget 请查看 [widget 目录](https://docs.flutter.cn/ui/widgets)。

                    本页内容对你有帮助吗？

                      thumb_up
                      thumb_down

                  除非另有说明，本文档之所提及适用于 Flutter 3.44.0 版本。[为本页面内容提出建议](https://github.com/cfug/flutter.cn/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.cn/ui/widgets/layout)。
