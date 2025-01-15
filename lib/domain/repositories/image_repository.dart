import '../entities/image_prompt.dart';

/// 画像生成のための抽象リポジトリインターフェース。
abstract class ImageRepository {
  /// プロンプトを元に画像を生成し、生成された画像のURLを返す。
  ///
  /// [prompt] 画像生成に使用するプロンプト。
  ///
  /// 画像生成に失敗した場合は例外をスローする。
  Future<String> generateImage(ImagePrompt prompt);
}
