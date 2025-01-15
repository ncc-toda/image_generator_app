import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';

class AdjectiveRoulette extends ConsumerWidget {
  const AdjectiveRoulette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageGeneratorProvider);

    return Column(
      children: [
        ElevatedButton(
          onPressed: state.isLoading
              ? null
              : () => ref
                  .read(imageGeneratorProvider.notifier)
                  .startAdjectiveRoulette(),
          child: const Text('形容詞を選ぶ'),
        ),
        const SizedBox(height: 20),
        if (state.isLoading)
          const CircularProgressIndicator()
        else if (state.value?.selectedAdjective != null)
          Text(
            '選ばれた形容詞: ${state.value!.selectedAdjective}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
      ],
    );
  }
}
