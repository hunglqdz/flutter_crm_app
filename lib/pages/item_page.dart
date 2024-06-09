import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/item.dart';
import 'package:flutter_crm_app/providers/item_provider.dart';
import 'package:provider/provider.dart';

import 'edit_item_page.dart';

class ItemPage extends StatelessWidget {
  final Item item;

  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemClass>(
      builder: ((context, provider, child) => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  provider.nameController.text = item.name;
                  provider.noteController.text = item.note;
                  provider.image = item.image;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EditItemPage(item: item))));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  provider.deleteItem(item);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: !Provider.of<ItemClass>(context).isDark
                          ? Colors.blue
                          : null,
                      borderRadius: BorderRadius.circular(5)),
                  height: 170,
                  child: item.image == null
                      ? const Center(
                          child: CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.photo),
                          ),
                        )
                      : Image.file(item.image!),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(item.name),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(item.note),
                ),
              ],
            ),
          ))),
    );
  }
}
