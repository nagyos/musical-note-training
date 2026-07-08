import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';

/// Visual content shown on the staff for a card question.
class NotationPayload {
  const NotationPayload({
    required this.clef,
    required this.elements,
  });

  final Clef clef;
  final List<NotationElement> elements;

  factory NotationPayload.fromJson(Map<String, dynamic> json) {
    final rawElements = json['elements'] as List<dynamic>;
    return NotationPayload(
      clef: Clef.values.byName(json['clef'] as String),
      elements: rawElements
          .map((e) => NotationElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clef': clef.name,
      'elements': elements.map((e) => e.toJson()).toList(),
    };
  }
}