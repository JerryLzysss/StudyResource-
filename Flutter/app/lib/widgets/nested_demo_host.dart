import 'package:flutter/material.dart';

/// 将示例嵌进外层详情页时隐藏内层 Scaffold 的 AppBar，避免双重返回栏。
Widget embedDemoWithoutAppBar(Widget demo, BuildContext context) {
  // StatelessWidget：直接拿到 Scaffold，去掉 appBar，最干净。
  if (demo is StatelessWidget) {
    // ignore: invalid_use_of_protected_member
    final built = demo.build(context);
    if (built is Scaffold) {
      return _scaffoldWithoutAppBar(built);
    }
  }

  // StatefulWidget（如计数器示例）：无法安全调用 build，用 Theme 压扁 AppBar。
  return _hideAppBarByTheme(demo, context);
}

Scaffold _scaffoldWithoutAppBar(Scaffold scaffold) {
  return Scaffold(
    body: scaffold.body,
    floatingActionButton: scaffold.floatingActionButton,
    floatingActionButtonLocation: scaffold.floatingActionButtonLocation,
    floatingActionButtonAnimator: scaffold.floatingActionButtonAnimator,
    persistentFooterButtons: scaffold.persistentFooterButtons,
    bottomNavigationBar: scaffold.bottomNavigationBar,
    bottomSheet: scaffold.bottomSheet,
    backgroundColor: scaffold.backgroundColor,
    resizeToAvoidBottomInset: scaffold.resizeToAvoidBottomInset,
    primary: false,
    drawer: scaffold.drawer,
    endDrawer: scaffold.endDrawer,
    extendBody: scaffold.extendBody,
    extendBodyBehindAppBar: false,
  );
}

Widget _hideAppBarByTheme(Widget demo, BuildContext context) {
  final theme = Theme.of(context);

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          toolbarHeight: 0,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
          titleTextStyle: const TextStyle(fontSize: 0, height: 0),
          toolbarTextStyle: const TextStyle(fontSize: 0, height: 0),
          iconTheme: const IconThemeData(size: 0, opacity: 0),
          actionsIconTheme: const IconThemeData(size: 0, opacity: 0),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            minimumSize: Size.zero,
            maximumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ),
      child: demo,
    ),
  );
}
