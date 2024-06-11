import 'package:flutter/material.dart';

import '../models/item.dart';
import '../pages/item_page.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemPage(item: item)));
      },
      child: Card(
        color: Colors.blue.shade100,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: item.image == null
                  ? const SizedBox(
                      width: 200,
                      height: 200,
                      child: Icon(Icons.local_restaurant),
                    )
                  : Image.file(
                      item.image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
            ),
            Expanded(
              child: Center(child: Text(item.name)),
            ),
          ],
        ),
      ),
    );
  }
}
