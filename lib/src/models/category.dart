import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String categoryName;
  final int totalRecipes;
  CategoryModel({
    required this.categoryName,
    required this.totalRecipes,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryName: json['categoryName'], totalRecipes: json['totalRecipes']);
  }
  @override
  List<Object?> get props => [categoryName, totalRecipes];
}
