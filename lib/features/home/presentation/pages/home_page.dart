import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/constants/app_constants.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_canvas.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StaffCanvas(),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _NavButton(label: 'Catalog', route: AppRoutes.catalog),
                _NavButton(label: 'Study', route: AppRoutes.study),
                _NavButton(label: 'Decks', route: AppRoutes.decks),
                _NavButton(label: 'Weak items', route: AppRoutes.weakItems),
                _NavButton(label: 'Settings', route: AppRoutes.settings),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () => context.go(route),
      child: Text(label),
    );
  }
}