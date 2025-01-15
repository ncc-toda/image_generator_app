import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/image_prompt.dart';
import '../../domain/repositories/image_repository.dart';

part 'openai_image_repository.g.dart';

/// OpenAIの画像生成APIを使用するためのリポジトリプロバイダー。
@riverpod
ImageRepository imageRepository(Ref ref) {
  return OpenAIImageRepository();
}

/// OpenAIのDALL-E APIを使用して画像を生成するリポジトリの実装。
class OpenAIImageRepository implements ImageRepository {
  @override
  Future<String?> generateImage(ImagePrompt prompt) async {
    OpenAI.apiKey = const String.fromEnvironment('OPENAI_API_KEY');

    final image = await OpenAI.instance.image.create(
      prompt: prompt.combined,
      n: 1,
      size: OpenAIImageSize.size1024,
      responseFormat: OpenAIImageResponseFormat.url,
    );

    return image.data.first.url;
  }
}
