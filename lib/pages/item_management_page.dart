import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/category.dart';
import 'package:flutter_crm_app/widgets/category_widget.dart';

class ItemManagementPage extends StatefulWidget {
  const ItemManagementPage({super.key});

  @override
  State<ItemManagementPage> createState() => _ItemManagementPageState();
}

class _ItemManagementPageState extends State<ItemManagementPage> {
  final List<Category> categories = [];
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton.icon(
        style:
            ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
        onPressed: () => _displayDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            searchBox(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: categories.map((Category category) {
                  return CategoryWidget(
                    category: category,
                    onDelete: _deleteCategory,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }

  void _deleteCategory(int id) {
    setState(() {
      categories.removeWhere((item) => item.id == id);
    });
  }

  void _addCategory(String name) {
    setState(() {
      categories.add(Category(id: 0, name: name));
    });
    categoryController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new category'),
          content: TextField(
            controller: categoryController,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addCategory(categoryController.text);
              },
              child: const Text('Add', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
