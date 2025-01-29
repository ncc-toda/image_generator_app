import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes/app_router.dart';
import '../widgets/dialogs/adjective_roulette_dialog.dart';

@RoutePage()
class NounInputPage extends StatefulWidget {
  const NounInputPage({super.key});

  @override
  State<NounInputPage> createState() => _NounInputPageState();
}

class _NounInputPageState extends State<NounInputPage> {
  final _nounController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('名詞を入力'),
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
            ElevatedButton(
              onPressed: () {
                if (_nounController.text.isNotEmpty) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AdjectiveRouletteDialog(
                      noun: _nounController.text,
                    ),
                  );
                }
              },
              child: const Text('生成'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nounController.dispose();
    super.dispose();
  }
}
