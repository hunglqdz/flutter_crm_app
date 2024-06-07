import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crm_app/data_repository/db_helper.dart';
import 'package:flutter_crm_app/models/item.dart';

class ItemClass extends ChangeNotifier {
  ItemClass() {
    getItems();
  }

  bool isDark = false;
  changeMode() {
    isDark = !isDark;
    notifyListeners();
  }

  final nameController = TextEditingController();
  final noteController = TextEditingController();
  File? image;

  List<Item> allItems = [];

  getItems() async {
    allItems = await DbHelper.dbHelper.getAllItems();
    notifyListeners();
  }

  addNewItem() {
    Item item = Item(
      name: nameController.text,
      note: noteController.text,
      image: image,
    );
    DbHelper.dbHelper.addNewItem(item);
    getItems();
  }

  updateItem(Item item) async {
    await DbHelper.dbHelper.updateItem(item);
    getItems();
  }

  deleteItem(Item item) {
    DbHelper.dbHelper.deleteItem(item);
    getItems();
  }
}
