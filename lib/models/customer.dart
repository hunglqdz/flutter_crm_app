class Customer {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String email;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  factory Customer.fromSqfliteDatabase(Map<String, dynamic> map) => Customer(
        id: map['id'] ?? 0,
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        email: map['email'] ?? '',
      );
}
