import 'package:flutter/material.dart';
import 'package:medi_gen/features/data/meals_model.dart';
import 'package:medi_gen/features/data/model.dart';
import 'package:medi_gen/features/domain/services.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Meal> _meals = [];
  bool _isLoading = false;
  String? _errorMessage;
  final List<Meal> _cartItems = [];

  List<Meal> get cartItems => _cartItems;
  List<Category> get categories => _categories;
  List<Meal> get meals => _meals;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void addToCart(Meal meal) {
    _cartItems.add(meal);
    notifyListeners();
  }

  void removeToCart(Meal meal) {
    _cartItems.remove(meal);
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await ApiService().fetchCategories();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMealsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _meals = await ApiService().fetchMealsByCategory(category);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMeals(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _meals = await ApiService().searchMeals(query);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
