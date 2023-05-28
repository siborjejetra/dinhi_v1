class Product {
  final String imagePath;
  final String name;
  final int price;
  final int quantity;
  final String unit;
  final String description;
  final String rating;

  const Product(
      {required this.imagePath,
      required this.name,
      required this.price,
      required this.quantity,
      required this.unit,
      required this.description,
      required this.rating});
}
