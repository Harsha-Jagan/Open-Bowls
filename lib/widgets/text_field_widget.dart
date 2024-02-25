import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _textController = TextEditingController();
  String _currentText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adding padding to all sides
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Ask a question...',
                contentPadding: EdgeInsets.all(16.0),
              ),
              onSubmitted: (text) {
                _handleSubmit(text);
              },
            ),
          ),
          const SizedBox(
              width:
                  8.0), // Adding some space between the text field and button
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              _handleSubmit(_textController.text);
            },
            iconSize: 24.0, // Adjust the size of the icon
          ),
        ],
      ),
    );
  }

  void _handleSubmit(String text) {
    setState(() {
      _currentText = text;
      _textController.clear();
    });
  }
}
