import 'package:flutter/material.dart';
import 'package:flutter_crm_app/widgets/my_textfield.dart';

import '../models/customer.dart';

class AddCustomerPage extends StatefulWidget {
  final Customer? customer;
  final Function onSubmit;

  const AddCustomerPage({
    super.key,
    this.customer,
    required this.onSubmit,
  });

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.customer?.name ?? '';
    phoneController.text = widget.customer?.phone ?? '';
    addressController.text = widget.customer?.address ?? '';
    emailController.text = widget.customer?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.customer != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Customer' : 'Add Customer'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // TextFormField(
                //   autofocus: true,
                //   controller: nameController,
                //   decoration: const InputDecoration(hintText: 'Name'),
                //   validator: (value) =>
                //       value != null && value.isEmpty ? 'Name is required' : null,
                // ),
                MyTextField(
                  icon: Icons.person,
                  label: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  icon: Icons.phone,
                  label: 'Phone',
                  controller: phoneController,
                ),
                const SizedBox(height: 20),

                MyTextField(
                  icon: Icons.location_city,
                  label: 'Address',
                  controller: addressController,
                ),
                const SizedBox(height: 20),

                MyTextField(
                  icon: Icons.email,
                  label: 'Email',
                  controller: emailController,
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
                                phoneController.text,
                                addressController.text,
                                emailController.text,
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
