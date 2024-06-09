import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crm_app/providers/item_provider.dart';
import 'package:flutter_crm_app/widgets/my_button.dart';
import 'package:flutter_crm_app/widgets/my_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    Provider.of<ItemClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Consumer<ItemClass>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    PopupMenuButton(
                      color: !provider.isDark ? Colors.blue.shade100 : null,
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                              onTap: (() =>
                                  pickImage(context, ImageSource.camera)),
                              child: const Row(
                                children: [
                                  Icon(Icons.camera_alt),
                                  SizedBox(width: 5),
                                  Text('Take a photo'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: (() =>
                                  pickImage(context, ImageSource.gallery)),
                              child: const Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(width: 5),
                                  Text('Select from gallery'),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const Text('Add an image'),
                  ],
                ),
                Visibility(
                  visible: provider.image != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      provider.image != null
                          ? Image.file(
                              provider.image!,
                              width: 200,
                              height: 200,
                            )
                          : Container(),
                      IconButton(
                        onPressed: () {
                          provider.image = null;
                          setState(() {});
                        },
                        icon: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  label: 'Item Name',
                  icon: Icons.abc,
                  controller: provider.nameController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  label: 'Item Note',
                  icon: Icons.note,
                  controller: provider.noteController,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    MyButton(
                      label: 'Save Item',
                      onPressed: () {
                        provider.addNewItem();
                        provider.nameController.clear();
                        provider.noteController.clear();
                        provider.image = null;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
