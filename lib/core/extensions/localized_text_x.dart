import 'package:flutter/widgets.dart';

import 'package:musical_note_training/shared/domain/models/localized_text.dart';

extension LocalizedTextX on LocalizedText {
  String resolveFrom(BuildContext context) {
    final code = Localizations.localeOf(context).languageCode;
    return resolve(code);
  }
}