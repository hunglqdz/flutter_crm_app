// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_crm_app/widgets/item_widget.dart';

import '../models/item.dart';

class SearchItemPage extends StatefulWidget {
  final List<Item> items;
  List<Item> filteredItems = [];
  SearchItemPage({super.key, required this.items}) {
    filteredItems = items;
  }

  @override
  State<SearchItemPage> createState() => _SearchItemPageState();
}

class _SearchItemPageState extends State<SearchItemPage> {
  void filterItems(value) {
    setState(() {
      widget.filteredItems = widget.items
          .where(
              (item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            filterItems(value);
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Search Item',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: widget.filteredItems.isNotEmpty
            ? ListView.builder(
                itemCount: widget.filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemWidget(widget.filteredItems[index]);
                },
              )
            : const Center(
                child: Text('Item Not Found'),
              ),
      ),
    );
  }
}
