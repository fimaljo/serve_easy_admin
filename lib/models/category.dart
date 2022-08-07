class Category {
  final String categoryImage;
  final String categoryName;

  Category({
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
