class Category {
  final String categoryName;
  final String categoryImage;
  final String categoryId;
  final String uid;
  Category({
    required this.categoryName,
    required this.categoryImage,
    required this.categoryId,
    required this.uid,
  });
  Map<String, dynamic> toMap() {
    return {
      'categoryImage': categoryImage,
      'categoryName': categoryName,
      'categoryId': categoryId,
      'uid': uid,
    };
  }

  Category.fromMap(Map<String, dynamic> map)
      : categoryImage = map['categoryImage'] ?? "",
        categoryName = map['categoryName'] ?? "",
        categoryId = map['categoryId'] ?? "",
        uid = map['uid'] ?? "";
}
//categoryId = map['categoryId'] ?? "",