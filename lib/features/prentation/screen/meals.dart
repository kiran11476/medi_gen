import 'package:flutter/material.dart';
import 'package:medi_gen/features/prentation/provider/controller.dart';
import 'package:provider/provider.dart';

class MealPage extends StatefulWidget {
  final String categoryName;

  MealPage({required this.categoryName});

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => Provider.of<CategoryProvider>(context, listen: false)
        .fetchMealsByCategory(widget.categoryName));
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<CategoryProvider>(context);
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          title: Text('${widget.categoryName} Meals'), centerTitle: true),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search Meals',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  await mealProvider.searchMeals(searchController.text);
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: mealProvider.isLoading
                ? const CircularProgressIndicator()
                : mealProvider.errorMessage != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Error:${mealProvider.errorMessage}',
                            style: const TextStyle(color: Colors.red)))
                    : ListView.builder(
                        itemCount: mealProvider.meals.length,
                        itemBuilder: (context, index) {
                          final meal = mealProvider.meals[index];

                          return Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: ListTile(
                                trailing: TextButton(
                                    onPressed: () {
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .addToCart(meal);
                                    },
                                    child: const Text("Add to cart")),
                                title: Text(meal.name),
                                leading: Image.network(
                                  meal.imageUrl,
                                  height: 50,
                                  width: 50,
                                ),
                                onTap: () {},
                              ));
                        },
                      ),
          ),
        ),
      ]),
    );
  }
}
