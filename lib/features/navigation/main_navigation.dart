import 'package:flutter/material.dart';

class MainNavigation extends InheritedWidget {
  final Function(int)? onSwitchTab;

  const MainNavigation({super.key, this.onSwitchTab, required super.child});

  static MainNavigation? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainNavigation>();
  }

  void switchTab(int index) {
    onSwitchTab?.call(index);
  }

  @override
  bool updateShouldNotify(MainNavigation oldWidget) {
    return onSwitchTab != oldWidget.onSwitchTab;
  }
}
