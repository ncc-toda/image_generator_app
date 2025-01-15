import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';

/// 形容詞をランダムに選択するルーレットウィジェット。
class AdjectiveRoulette extends ConsumerWidget {
  const AdjectiveRoulette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageGeneratorProvider);

    return state.when(
      data: (data) => Column(
        children: [
          ElevatedButton(
            onPressed: () => ref
                .read(imageGeneratorProvider.notifier)
                .startAdjectiveRoulette(),
            child: const Text('形容詞を選ぶ'),
          ),
          if (data.selectedAdjective != null) ...[
            const SizedBox(height: 20),
            Text(
              '選ばれた形容詞: ${data.selectedAdjective}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ],
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('エラーが発生しました: $error'),
    );
  }
}
