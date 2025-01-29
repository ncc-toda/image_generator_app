import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';

@RoutePage()
class ImageDisplayPage extends ConsumerStatefulWidget {
  const ImageDisplayPage({
    super.key,
    @PathParam('noun') required this.noun,
    @PathParam('adjective') required this.adjective,
  });

  final String noun;
  final String adjective;

  @override
  ConsumerState<ImageDisplayPage> createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends ConsumerState<ImageDisplayPage> {
  @override
  void initState() {
    super.initState();
    // 画面表示後に自動で画像生成を開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageGeneratorProvider.notifier).generateImage(widget.noun);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('生成された画像'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: state.when(
          data: (data) {
            if (data.generatedImageUrl == null) {
              return const Center(child: Text('画像を生成中...'));
            }
            return Column(
              children: [
                Text(
                  '${widget.adjective}${widget.noun}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Image.network(
                    data.generatedImageUrl!,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('画像を生成しています...'),
              ],
            ),
          ),
          error: (error, _) => Center(
            child: Text('エラーが発生しました: $error'),
          ),
        ),
      ),
    );
  }
}
