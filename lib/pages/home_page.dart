import 'package:flutter/material.dart';
import 'package:frontend/classes/item_class.dart';
import 'package:frontend/widgets/card_widget.dart';
import 'package:frontend/widgets/text_field_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Arms'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardWidget(
                boxInfo: ItemClass(
                    title: 'How can we help you?',
                    imagePath: 'images/yeah.png')),
            const TextFieldWidget(),
            Row(
              children: [
                Expanded(
                    child: CardWidget(
                        boxInfo: ItemClass(
                            title: 'Travel', imagePath: 'images/travel.png'))),
                Expanded(
                    child: CardWidget(
                        boxInfo: ItemClass(
                            title: 'Space', imagePath: 'images/space.png'))),
              ],
            ),
            CardWidget(
                boxInfo:
                    ItemClass(title: 'Yeah', imagePath: 'images/yeah.png')),
          ],
        ),
      ),
    );
  }
}
