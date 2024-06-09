import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/category.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
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
    return Consumer<ItemClass>(
      builder: (BuildContext context, myProvider, Widget? child) =>
          GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryPage(category: category)));
        },
        onLongPress: () {
          onDelete(category.id);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            color: !Provider.of<ItemClass>(context).isDark
                ? Color((math.Random().nextDouble() * 0xffffff).toInt())
                    .withOpacity(0.5)
                : Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('${myProvider.allItems.length} items'),
            ],
          ),
        ),
      ),
    );
  }
}
