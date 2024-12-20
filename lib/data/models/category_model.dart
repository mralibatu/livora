class Category {
  final int id;
  final String categoryName;
  final int difficultyLevel;
  final bool isWordCategory;

  Category({
    required this.id,
    required this.categoryName,
    required this.difficultyLevel,
    required this.isWordCategory,
  });

  // Factory method to create a Category from a JSON map
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['category_name'],
      difficultyLevel: json['difficulty_level'],
      isWordCategory: json['isWordCategory'],
    );
  }

  // Method to convert a Category instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'difficulty_level': difficultyLevel,
      'isWordCategory': isWordCategory,
    };
  }
}
