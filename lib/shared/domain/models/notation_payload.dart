import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';

/// Visual content shown on the staff for a card question.
class NotationPayload {
  const NotationPayload({
    this.clef,
    this.dynamicMark,
    this.symbolMark,
    this.elements = const [],
  }) : assert(
          clef != null || dynamicMark != null || symbolMark != null,
          'Notation requires a clef or standalone mark',
        );

  final Clef? clef;
  final String? dynamicMark;
  final String? symbolMark;
  final List<NotationElement> elements;

  bool get isDynamicOnly =>
      dynamicMark != null && clef == null && symbolMark == null;

  bool get isSymbolOnly =>
      symbolMark != null && clef == null && dynamicMark == null;

  factory NotationPayload.fromJson(Map<String, dynamic> json) {
    final rawElements = json['elements'] as List<dynamic>? ?? const [];
    return NotationPayload(
      clef: json['clef'] == null
          ? null
          : Clef.values.byName(json['clef'] as String),
      dynamicMark: json['dynamicMark'] as String?,
      symbolMark: json['symbolMark'] as String?,
      elements: rawElements
          .map((e) => NotationElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (clef != null) 'clef': clef!.name,
      if (dynamicMark != null) 'dynamicMark': dynamicMark,
      if (symbolMark != null) 'symbolMark': symbolMark,
      'elements': elements.map((e) => e.toJson()).toList(),
    };
  }
}