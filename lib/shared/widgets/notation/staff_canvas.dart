import 'package:flutter/material.dart';

/// Placeholder for staff notation rendering (T-011).
///
/// Will draw a five-line staff and notes via [CustomPainter].
class StaffCanvas extends StatelessWidget {
  const StaffCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.black26)),
        ),
        child: Center(child: Text('Staff')),
      ),
    );
  }
}
