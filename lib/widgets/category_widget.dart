import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/category.dart';

import '../pages/category_page.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final onDelete;

  const CategoryWidget({
    super.key,
    required this.category,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CategoryPage()));
        },
        title: Text(category.name),
        subtitle: const Text('0 items'),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5),
          ),
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: () {
              onDelete(category.id);
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
