class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  static List<Category> categoryList() {
    return [
      Category(id: 1, name: 'Food'),
      Category(id: 2, name: 'Drink'),
      Category(id: 3, name: 'Cooking utensils'),
      Category(id: 4, name: 'Washing liquid'),
      Category(id: 5, name: 'Toy'),
    ];
  }
}
