import 'package:flutter/material.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/features/deck/domain/deck_validator.dart';

Future<String?> showCreateDeckDialog(BuildContext context) async {
  final l10n = context.l10n;
  final controller = TextEditingController();
  String? errorText;

  return showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(l10n.newDeckTitle),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: l10n.deckNameHint,
                errorText: errorText,
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
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
                child: Text(l10n.create),
              ),
            ],
          );
        },
      );
    },
  );
}