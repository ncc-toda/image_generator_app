import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/image_prompt.dart';
import '../../infrastructure/repositories/openai_image_repository.dart';

part 'image_generator_state.g.dart';

/// 画像生成アプリケーションの状態を管理するプロバイダー。
@riverpod
class ImageGenerator extends _$ImageGenerator {
  final _random = Random();

  /// 選択可能な形容詞のリスト。
  final List<String> _adjectives = [
    '美しい',
    '神秘的な',
    '可愛い',
    'カラフルな',
    '壮大な',
    'ファンタジックな',
    '未来的な',
    'レトロな',
    '優雅な',
    '荒々しい',
  ];

  @override
  AsyncValue<ImageGeneratorState> build() {
    return const AsyncValue.data(ImageGeneratorState());
  }

  /// ルーレットを開始し、ランダムな形容詞を選択する。
  ///
  /// 2秒間のアニメーション後に結果を表示する。
  Future<void> startAdjectiveRoulette() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));

    final selectedAdjective = _adjectives[_random.nextInt(_adjectives.length)];
    state = AsyncValue.data(
        ImageGeneratorState(selectedAdjective: selectedAdjective));
  }

  /// 指定された名詞と選択された形容詞を使用して画像を生成する。
  ///
  /// [noun] 画像生成に使用する名詞。
  Future<void> generateImage(String noun) async {
    if (state.value?.selectedAdjective == null) return;

    state = const AsyncValue.loading();

    try {
      final prompt = ImagePrompt(
        adjective: state.value!.selectedAdjective!,
        noun: noun,
      );

      final imageUrl =
          await ref.read(imageRepositoryProvider).generateImage(prompt);

      state = AsyncValue.data(ImageGeneratorState(
        selectedAdjective: state.value!.selectedAdjective,
        generatedImageUrl: imageUrl,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// 画像生成アプリケーションの状態を表現するクラス。
class ImageGeneratorState {
  /// 選択された形容詞。未選択の場合は null。
  final String? selectedAdjective;

  /// 生成された画像のURL。未生成の場合は null。
  final String? generatedImageUrl;

  const ImageGeneratorState({
    this.selectedAdjective,
    this.generatedImageUrl,
  });
}
