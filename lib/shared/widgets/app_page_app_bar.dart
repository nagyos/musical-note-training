import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Standard app bar for pushed sub-pages (back arrow when [GoRouter] can pop).
class AppPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppPageAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  final Widget title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leading: context.canPop() ? const BackButton() : null,
      automaticallyImplyLeading: context.canPop(),
    );
  }
}