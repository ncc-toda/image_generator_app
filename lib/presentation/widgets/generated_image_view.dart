import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';

/// 生成された画像を表示するウィジェット。
class GeneratedImageView extends ConsumerWidget {
  const GeneratedImageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageGeneratorProvider);

    return state.when(
      data: (data) {
        if (data.generatedImageUrl == null || data.generatedImageUrl!.isEmpty) {
          return const SizedBox.shrink();
        }
        return Expanded(
          child: CachedNetworkImage(
            imageUrl: data.generatedImageUrl!,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('画像の読み込みに失敗しました。'),
                    const SizedBox(height: 8),
                    Text('URL: ${data.generatedImageUrl}'),
                    const SizedBox(height: 8),
                    Text('エラー: $error'),
                  ],
                ),
              );
            },
            fit: BoxFit.contain,
          ),
        );
      },
      loading: () => const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) {
        return Expanded(
          child: Center(
            child: Text('エラーが発生しました: $error'),
          ),
        );
      },
    );
  }
}
