// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generator_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageGeneratorHash() => r'91f2029c9fe574fb1430176db1107d2a630d166b';

/// 画像生成アプリケーションの状態を管理するプロバイダー。
///
/// Copied from [ImageGenerator].
@ProviderFor(ImageGenerator)
final imageGeneratorProvider = AutoDisposeNotifierProvider<ImageGenerator,
    AsyncValue<ImageGeneratorState>>.internal(
  ImageGenerator.new,
  name: r'imageGeneratorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageGeneratorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImageGenerator = AutoDisposeNotifier<AsyncValue<ImageGeneratorState>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
