import 'package:flutter/material.dart';
import 'package:frontend/classes/item_class.dart';
import 'package:frontend/pages/description_page.dart';

import '../core/constants.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.boxInfo,
  });
  final ItemClass boxInfo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const DescriptionPage();
        }));
      },
      child: Card(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(kDouble10),
              child: Column(
                children: [
                  const SizedBox(
                    height: kDouble5,
                  ),
                  Image.asset(boxInfo.imagePath),
                  Text(
                    boxInfo.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('This is the ${boxInfo.title} description')
                ],
              ))),
    );
  }
}
