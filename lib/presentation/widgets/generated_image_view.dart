import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';

class GeneratedImageView extends ConsumerWidget {
  const GeneratedImageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageGeneratorProvider);

    if (state.value?.generatedImageUrl == null) return const SizedBox.shrink();

    return Expanded(
      child: Image.network(state.value!.generatedImageUrl!),
    );
  }
}
