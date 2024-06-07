import 'package:flutter/material.dart';
import 'package:flutter_crm_app/providers/item_provider.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../pages/item_page.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemPage(item: item)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: !Provider.of<ItemClass>(context).isDark
                ? Colors.blue[100]
                : null,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: ListTile(
          tileColor:
              !Provider.of<ItemClass>(context).isDark ? Colors.blue[100] : null,
          leading: item.image == null
              ? const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                )
              : Image.file(
                  item.image!,
                  width: 100,
                  height: double.infinity,
                ),
          title: Text(
            item.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(item.note),
        ),
      ),
    );
  }
}
