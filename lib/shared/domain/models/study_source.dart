/// Identifies where a study session gets its cards from.
///
/// Used by the [Study] feature so catalog, deck, and weak-item flows
/// share one quiz engine.
enum StudySourceType {
  catalog,
  deck,
  weakItems,
}
