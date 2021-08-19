import 'package:equatable/equatable.dart';

class RecipeModel extends Equatable {
  final String name;

  RecipeModel({required this.name});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(name: json['name']);
  }

  @override
  List<Object?> get props => [name];
}
