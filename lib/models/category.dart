class Category {
  // final String categoryId;
  final String categoryImage;
  final String categoryName;

  Category(
      // this.categoryId,
      {
    required this.categoryImage,
    required this.categoryName,
  });
  Map<String, dynamic> toMap() {
    return {
      'categoryImage': categoryImage,
      'categoryName': categoryName,
    };
  }

  Category.fromMap(Map<String, dynamic> map)
      : categoryImage = map['categoryImage'] ?? "",
        categoryName = map['categoryName'] ?? "";
}
//categoryId = map['categoryId'] ?? "",