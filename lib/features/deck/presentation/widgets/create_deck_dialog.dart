import 'package:flutter/material.dart';

import 'package:musical_note_training/features/deck/domain/deck_validator.dart';

Future<String?> showCreateDeckDialog(BuildContext context) async {
  final controller = TextEditingController();
  String? errorText;

  return showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('新しいデッキ'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: '名前',
                errorText: errorText,
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              FilledButton(
                onPressed: () {
                  try {
                    final name = DeckValidator.validateName(controller.text);
                    Navigator.pop(context, name);
                  } on DeckValidationException catch (e) {
                    setState(() => errorText = e.message);
                  }
                },
                child: const Text('作成'),
              ),
            ],
          );
        },
      );
    },
  );
}