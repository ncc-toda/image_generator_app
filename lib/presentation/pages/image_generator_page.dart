import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/states/image_generator_state.dart';
import '../widgets/adjective_roulette.dart';
import '../widgets/generated_image_view.dart';

class ImageGeneratorPage extends ConsumerStatefulWidget {
  const ImageGeneratorPage({super.key});

  @override
  ConsumerState<ImageGeneratorPage> createState() => _ImageGeneratorPageState();
}

class _ImageGeneratorPageState extends ConsumerState<ImageGeneratorPage> {
  final _nounController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI画像ジェネレーター'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nounController,
              decoration: const InputDecoration(
                labelText: '名詞を入力してください',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const AdjectiveRoulette(),
            const SizedBox(height: 20),
            if (state.value?.selectedAdjective != null)
              ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () => ref
                        .read(imageGeneratorProvider.notifier)
                        .generateImage(_nounController.text),
                child: const Text('画像を生成'),
              ),
            const SizedBox(height: 20),
            const GeneratedImageView(),
          ],
        ),
      ),
    );
  }
}
