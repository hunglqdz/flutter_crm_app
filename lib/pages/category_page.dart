import 'package:flutter/material.dart';

import 'add_item_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton.icon(
        style:
            ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemPage(
                onSubmit: () {},
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Item'),
      ),
      appBar: AppBar(),
    );
  }
}
