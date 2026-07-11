import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';

/// Visual content for a card question.
///
/// Standalone mark fields ([dynamicMark], [symbolMark], [tempoMark], [restMark])
/// are orthogonal: each drives its own renderer without clef or [elements].
/// Staff-based notation uses [clef] with note [elements] only.
class NotationPayload {
  const NotationPayload({
    this.clef,
    this.dynamicMark,
    this.symbolMark,
    this.tempoMark,
    this.restMark,
    this.elements = const [],
  }) : assert(
          clef != null ||
              dynamicMark != null ||
              symbolMark != null ||
              tempoMark != null ||
              restMark != null,
          'Notation requires a clef or standalone mark',
        );

  final Clef? clef;
  final String? dynamicMark;
  final String? symbolMark;
  final String? tempoMark;
  final String? restMark;
  final List<NotationElement> elements;

  bool get isDynamicOnly =>
      dynamicMark != null &&
      clef == null &&
      symbolMark == null &&
      tempoMark == null &&
      restMark == null;

  bool get isSymbolOnly =>
      symbolMark != null &&
      clef == null &&
      dynamicMark == null &&
      tempoMark == null &&
      restMark == null;

  bool get isTempoOnly =>
      tempoMark != null &&
      clef == null &&
      dynamicMark == null &&
      symbolMark == null &&
      restMark == null;

  bool get isRestOnly =>
      restMark != null &&
      clef == null &&
      dynamicMark == null &&
      symbolMark == null &&
      tempoMark == null;

  factory NotationPayload.fromJson(Map<String, dynamic> json) {
    final rawElements = json['elements'] as List<dynamic>? ?? const [];
    return NotationPayload(
      clef: json['clef'] == null
          ? null
          : Clef.values.byName(json['clef'] as String),
      dynamicMark: json['dynamicMark'] as String?,
      symbolMark: json['symbolMark'] as String?,
      tempoMark: json['tempoMark'] as String?,
      restMark: json['restMark'] as String?,
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
      if (tempoMark != null) 'tempoMark': tempoMark,
      if (restMark != null) 'restMark': restMark,
      'elements': elements.map((e) => e.toJson()).toList(),
    };
  }
}