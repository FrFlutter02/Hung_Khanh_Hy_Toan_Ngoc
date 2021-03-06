import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/constant_text.dart';
import '../models/recipe_model.dart';

class SearchServices {
  Future<List<RecipeModel>> searcRecipesByName(String searchQuery) async {
    final _recipesUrl =
        'https://api.edamam.com/api/recipes/v2?type=public&q=$searchQuery&app_id=7024d4bb&app_key=cc06283adc212290729acaf0fe2520d9';
    final _response = await http.get(Uri.parse(_recipesUrl));
    if (_response.statusCode == 200) {
      final _body = jsonDecode(_response.body);
      final _hits = Map<String, dynamic>.from(_body)['hits'];
      final _labels =
          _hits.map((hit) => RecipeModel(name: hit['recipe']['label']));
      return List<RecipeModel>.from(_labels);
    } else {
      throw SearchScreenText.searchErrorMessage;
    }
  }
}
