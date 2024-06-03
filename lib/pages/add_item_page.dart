import 'package:flutter/material.dart';
import 'package:flutter_crm_app/widgets/my_textfield.dart';

class AddItemPage extends StatefulWidget {
  final Item? item;
  final Function onSubmit;

  const AddItemPage({
    super.key,
    this.item,
    required this.onSubmit,
  });

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final nameController = TextEditingController();
  final noteController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.item?.name ?? '';
    noteController.text = widget.item?.note ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Item' : 'Add Item'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                MyTextField(
                  icon: Icons.abc,
                  hint: 'Enter Name',
                  label: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  icon: Icons.phone,
                  hint: 'Enter Note',
                  label: 'Note',
                  controller: noteController,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: FilledButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              widget.onSubmit(
                                nameController.text,
                                noteController.text,
                              );
                            }
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
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
