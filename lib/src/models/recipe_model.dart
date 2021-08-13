class RecipeModel {
  final String name;

  RecipeModel({required this.name});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(name: json['name']);
  }
}
