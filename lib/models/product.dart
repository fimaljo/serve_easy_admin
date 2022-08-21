class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final dynamic productid;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.productid,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'productid': productid,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        description = map['description'] ?? "",
        price = map['price'] ?? 0.0,
        imageUrl = map['imageUrl'] ?? "",
        productid = map['productid'] ?? "";
}
