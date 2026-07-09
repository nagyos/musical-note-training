import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/extensions/localized_text_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/shared/widgets/app_page_app_bar.dart';
import 'package:musical_note_training/shared/domain/models/category.dart';
import 'package:musical_note_training/shared/domain/models/lesson.dart';

final categoryProvider = FutureProvider.family<Category?, String>((ref, id) async {
  final categories = await ref.read(cardRepositoryProvider).getCategories();
  for (final category in categories) {
    if (category.id == id) return category;
  }
  return null;
});

final categoryLessonsProvider =
    FutureProvider.family<List<Lesson>, String>((ref, categoryId) {
  return ref.read(cardRepositoryProvider).getLessons(categoryId);
});

class CatalogLessonListPage extends ConsumerWidget {
  const CatalogLessonListPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final lessonsAsync = ref.watch(categoryLessonsProvider(categoryId));
    final categoryAsync = ref.watch(categoryProvider(categoryId));

    final title = categoryAsync.maybeWhen(
      data: (category) => category?.title.resolveFrom(context) ?? categoryId,
      orElse: () => categoryId,
    );

    return Scaffold(
      appBar: AppPageAppBar(title: Text(title)),
      body: lessonsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text(l10n.loadLessonsFailed('$error'))),
        data: (lessons) {
          if (lessons.isEmpty) {
            return Center(child: Text(l10n.noLessonsYet));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: lessons.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return Card(
                child: ListTile(
                  title: Text(lesson.title.resolveFrom(context)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.studyLesson(lesson.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}