import 'package:musical_note_training/shared/domain/models/note_value.dart';

/// A single note or rest drawn on the staff.
///
/// [staffStep] follows standard music engraving: 0 = bottom line (E4 in treble),
/// positive steps move upward by half-line spacing.
class NotationElement {
  const NotationElement({
    required this.staffStep,
    required this.value,
    this.isRest = false,
    this.accidental,
  });

  final int staffStep;
  final NoteValue value;
  final bool isRest;

  /// Semitone offset: -1 flat, 0 natural, 1 sharp. Null means no accidental drawn.
  final int? accidental;

  factory NotationElement.fromJson(Map<String, dynamic> json) {
    return NotationElement(
      staffStep: json['staffStep'] as int,
      value: NoteValue.values.byName(json['value'] as String),
      isRest: json['isRest'] as bool? ?? false,
      accidental: json['accidental'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'staffStep': staffStep,
      'value': value.name,
      if (isRest) 'isRest': isRest,
      if (accidental != null) 'accidental': accidental,
    };
  }
}