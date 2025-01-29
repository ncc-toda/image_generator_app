import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/states/image_generator_state.dart';
import 'image_display_dialog.dart';

class ImageGeneratingDialog extends ConsumerStatefulWidget {
  const ImageGeneratingDialog({
    super.key,
    required this.noun,
    required this.adjective,
  });

  final String noun;
  final String adjective;

  @override
  ConsumerState<ImageGeneratingDialog> createState() =>
      _ImageGeneratingDialogState();
}

class _ImageGeneratingDialogState extends ConsumerState<ImageGeneratingDialog> {
  @override
  void initState() {
    super.initState();
    // ダイアログ表示後に自動で画像生成を開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageGeneratorProvider.notifier).generateImage(widget.noun);
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
            if (data.generatedImageUrl != null) {
              // 画像生成完了したら画像表示ダイアログを表示
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => ImageDisplayDialog(
                    noun: widget.noun,
                    adjective: widget.adjective,
                    imageUrl: data.generatedImageUrl!,
                  ),
                );
              });
            }
            return const SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('画像を生成しています...'),
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
                Text('画像を生成しています...'),
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
