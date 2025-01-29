import 'package:flutter/material.dart';

class ImageDisplayDialog extends StatelessWidget {
  const ImageDisplayDialog({
    super.key,
    required this.noun,
    required this.adjective,
    required this.imageUrl,
  });

  final String noun;
  final String adjective;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$adjective$noun',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Image.network(
              imageUrl,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('閉じる'),
            ),
          ],
        ),
      ),
    );
  }
} 
