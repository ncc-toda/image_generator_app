/// 画像生成のためのプロンプトを表現するエンティティクラス。
///
/// [adjective] と [noun] を組み合わせて画像生成用のプロンプトを作成する。
class ImagePrompt {
  /// 形容詞。
  final String adjective;

  /// 名詞。
  final String noun;

  const ImagePrompt({
    required this.adjective,
    required this.noun,
  });

  /// 形容詞と名詞を組み合わせた完全なプロンプト文字列を返す。
  String get combined => '$adjective $noun';
}
