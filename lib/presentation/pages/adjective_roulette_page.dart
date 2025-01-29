import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';
import '../routes/app_router.dart';

@RoutePage()
class AdjectiveRoulettePage extends ConsumerStatefulWidget {
  const AdjectiveRoulettePage({
    super.key,
    @PathParam('noun') required this.noun,
  });

  final String noun;

  @override
  ConsumerState<AdjectiveRoulettePage> createState() =>
      _AdjectiveRoulettePageState();
}

class _AdjectiveRoulettePageState extends ConsumerState<AdjectiveRoulettePage> {
  @override
  void initState() {
    super.initState();
    // 画面表示後に自動でルーレットを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageGeneratorProvider.notifier).startAdjectiveRoulette();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('形容詞ルーレット'),
      ),
      body: Center(
        child: state.when(
          data: (data) {
            if (data.selectedAdjective != null) {
              // 形容詞が選ばれたら画像生成画面に遷移
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.router.push(
                  ImageDisplayRoute(
                    noun: widget.noun,
                    adjective: data.selectedAdjective!,
                  ),
                );
              });
            }
            return const Text('ルーレット中...');
          },
          loading: () => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('形容詞を選んでいます...'),
            ],
          ),
          error: (error, _) => Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }
}
