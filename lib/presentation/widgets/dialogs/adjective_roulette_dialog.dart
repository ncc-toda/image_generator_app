import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/states/image_generator_state.dart';
import 'image_generating_dialog.dart';

class AdjectiveRouletteDialog extends ConsumerStatefulWidget {
  const AdjectiveRouletteDialog({
    super.key,
    required this.noun,
  });

  final String noun;

  @override
  ConsumerState<AdjectiveRouletteDialog> createState() =>
      _AdjectiveRouletteDialogState();
}

class _AdjectiveRouletteDialogState
    extends ConsumerState<AdjectiveRouletteDialog> {
  @override
  void initState() {
    super.initState();
    // ダイアログ表示後に自動でルーレットを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageGeneratorProvider.notifier).startAdjectiveRoulette();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageGeneratorProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: state.when(
          data: (data) {
            if (data.selectedAdjective != null) {
              // 形容詞が選ばれたら画像生成ダイアログを表示
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ImageGeneratingDialog(
                    noun: widget.noun,
                    adjective: data.selectedAdjective!,
                  ),
                );
              });
            }
            return const SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ルーレット中...'),
                ],
              ),
            );
          },
          loading: () => const SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('形容詞を選んでいます...'),
              ],
            ),
          ),
          error: (error, _) => SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('エラーが発生しました: $error'),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
