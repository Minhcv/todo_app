import 'package:flutter/material.dart';

class MyCustomDialog extends StatefulWidget {
  const MyCustomDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCustomDialogState createState() => _MyCustomDialogState();
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nhập task mới'),
      content: TextFormField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          hintText: 'Nhập dữ liệu',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _textEditingController.text);
          },
          child: const Text('OK'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
