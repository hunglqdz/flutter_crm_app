import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crm_app/models/item.dart';
import 'package:flutter_crm_app/providers/item_provider.dart';
import 'package:flutter_crm_app/widgets/my_button.dart';
import 'package:flutter_crm_app/widgets/my_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditItemPage extends StatefulWidget {
  final Item item;
  const EditItemPage({super.key, required this.item});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
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
        title: const Text('Edit Item'),
        centerTitle: true,
      ),
      body: Consumer<ItemClass>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    PopupMenuButton(
                      color: !provider.isDark ? Colors.blue[100] : null,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          provider.image = null;
                          setState(() {});
                        },
                        icon: const Icon(Icons.cancel),
                      ),
                      provider.image != null
                          ? Image.file(
                              provider.image!,
                              width: 100,
                              height: 100,
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hint: 'Enter Name',
                  label: 'Item Name',
                  icon: Icons.abc,
                  controller: provider.nameController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hint: 'Enter Note',
                  label: 'Item Note',
                  icon: Icons.note,
                  controller: provider.noteController,
                ),
                const SizedBox(height: 20),
                MyButton(
                  label: 'Save Changes',
                  onPressed: () {
                    widget.item.name = provider.nameController.text;
                    widget.item.note = provider.noteController.text;
                    widget.item.image = provider.image;
                    provider.updateItem(widget.item);
                    provider.nameController.clear();
                    provider.noteController.clear();
                    provider.image = null;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
