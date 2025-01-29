import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
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
  static const model = 'dall-e-3';

  @override
  Future<String> generateImage(ImagePrompt prompt) async {
    try {
      final apiKey = dotenv.env['OPENAI_API_KEY'];
      if (apiKey == null) {
        throw Exception('OPENAI_API_KEYが設定されていません。');
      }

      OpenAI.apiKey = apiKey;

      final image = await OpenAI.instance.image.create(
        model: model,
        prompt: prompt.combined,
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );

      if (image.data.isEmpty) {
        throw Exception('画像生成に失敗しました。データが空です。');
      }

      final imageUrl = image.data.first.url;
      if (imageUrl == null || imageUrl.isEmpty) {
        throw Exception('画像URLの取得に失敗しました。');
      }

      // URLから画像データを取得して、base64エンコードされた文字列として返す
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('画像のダウンロードに失敗しました。ステータスコード: ${response.statusCode}');
      }

      final base64Image =
          'data:image/png;base64,${base64Encode(response.bodyBytes)}';
      return base64Image;
    } catch (e) {
      throw Exception('画像生成に失敗しました: $e');
    }
  }
}
