import 'dart:io';

class Item {
  int? id;
  late final String name;
  String? note;
  File? image;

  Item({
    this.id,
    required this.name,
    required this.note,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'image': image == null ? '' : image!.path,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      note: map['note'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }
}
