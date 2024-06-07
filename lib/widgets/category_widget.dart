import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/category.dart';
import 'package:provider/provider.dart';

import '../pages/category_page.dart';
import '../providers/item_provider.dart';

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
        color: !Provider.of<ItemClass>(context).isDark
            ? Colors.grey.shade100
            : null,
        border: Border.all(color: Colors.blue, width: 5),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryPage(category: category)));
        },
        title: Text(
          category.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('0 items'),
        trailing: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.blue),
          ),
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
