import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medi_gen/features/data/meals_model.dart';
import 'package:medi_gen/features/data/model.dart';

class ApiService {
  final String categoriesUrl =
      "https://www.themealdb.com/api/json/v1/1/categories.php";
  final String mealsUrl =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=";
  final String searchUrl =
      "https://www.themealdb.com/api/json/v1/1/search.php?s=";

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Category> categories = (data['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse(mealsUrl + category));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Meal> meals =
          (data['meals'] as List).map((meal) => Meal.fromJson(meal)).toList();
      return meals;
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse(searchUrl + query));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Meal> meals =
          (data['meals'] as List).map((meal) => Meal.fromJson(meal)).toList();
      return meals;
    } else {
      throw Exception('Failed to search meals');
    }
  }
}
