import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/recipe_card.dart';
import 'package:sri_cuisine/models/recipe.dart';
import 'package:sri_cuisine/pages/available_ingredients_screen.dart';
import 'package:sri_cuisine/pages/recipe_detail_page.dart';
import 'package:sri_cuisine/services/IngredientApi.dart';

class RecipesPage extends StatefulWidget {
  @override
  _Recipes createState() => _Recipes();
}

class _Recipes extends State<RecipesPage> {
  List<Recipe> recipesList = IngridientApi.recipeList;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Recommended Recipes'),
            Text(
              'Based on your ingredients',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: recipesList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.restaurant_menu,
                        color: colorScheme.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No recipes yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Add ingredients to generate personalized recipes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 18),
                    FilledButton.tonal(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AvailableIngredientsScreen(),
                          ),
                        );
                      },
                      child: const Text('Add ingredients'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 24, top: 8),
              itemCount: recipesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                          recipe: recipesList[index],
                        ),
                      ),
                    );
                  },
                  child: RecipeCard(
                    recipe: recipesList[index],
                    title: ("${recipesList[index].recipeName}"),
                    thumbnailUrl: ("${recipesList[index].image}"),
                    calorie: ("${recipesList[index].calorie}"),
                    cookTime: ("${recipesList[index].totalTimeInMins}"),
                  ),
                );
              },
            ),
    );
  }
}
