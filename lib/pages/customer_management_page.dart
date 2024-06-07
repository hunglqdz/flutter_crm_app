import 'package:flutter/material.dart';

import '../database/customer_db.dart';
import '../models/customer.dart';
import 'add_customer_page.dart';

class CustomerManagementPage extends StatefulWidget {
  const CustomerManagementPage({super.key});

  @override
  State<CustomerManagementPage> createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  Future<List<Customer>>? futureCustomers;
  final customerDB = CustomerDB();

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  void fetchCustomers() {
    setState(() {
      futureCustomers = customerDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton.icon(
        style:
            ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCustomerPage(
                onSubmit: (name, phone, address, email) async {
                  await customerDB.create(
                    name: name,
                    phone: phone,
                    address: address,
                    email: email,
                  );
                  if (!mounted) return;
                  fetchCustomers();
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            searchBox(),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Customer name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Phone number',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            FutureBuilder<List<Customer>>(
              future: futureCustomers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final customers = snapshot.data!;
                  return customers.isEmpty
                      ? const Center(
                          child: Text('No customers yet. Please add some!'),
                        )
                      : Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                final customer = customers[index];
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AddCustomerPage(
                                        customer: customer,
                                        onSubmit: (name, phone, address,
                                            email) async {
                                          await customerDB.update(
                                            id: customer.id,
                                            name: name,
                                            phone: phone,
                                            address: address,
                                            email: email,
                                          );
                                          fetchCustomers();
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            customer.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            customer.phone,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                await customerDB
                                                    .delete(customer.id);
                                                fetchCustomers();
                                              },
                                              icon: const Icon(
                                                Icons.call,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(),
                              itemCount: customers.length),
                        );
                }
              },
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
        // onChanged: (value) => _searchCategory(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search by phone',
        ),
      ),
    );
  }
}
