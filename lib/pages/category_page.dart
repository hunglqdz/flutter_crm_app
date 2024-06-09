import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/category.dart';
import 'package:flutter_crm_app/pages/search_item_page.dart';
import 'package:flutter_crm_app/providers/item_provider.dart';
import 'package:flutter_crm_app/widgets/item_widget.dart';
import 'package:provider/provider.dart';

import 'add_item_page.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemClass>(
        builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
              backgroundColor: !myProvider.isDark ? Colors.white : null,
              floatingActionButton: FilledButton.icon(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue)),
                onPressed: (() async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddItemPage()));
                }),
                label: const Text('Item'),
                icon: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Text(category.name),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  SearchItemPage(items: myProvider.allItems)))),
                      icon: const Icon(Icons.search))
                ],
              ),
              body: ListView.builder(
                itemCount: myProvider.allItems.length,
                itemBuilder: (context, index) {
                  return ItemWidget(myProvider.allItems[index]);
                },
              ),
            ));
  }
}
