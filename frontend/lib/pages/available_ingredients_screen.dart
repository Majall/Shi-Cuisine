import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/IngredientApi.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class AvailableIngredientsScreen extends StatefulWidget {
  const AvailableIngredientsScreen({super.key});

  @override
  _AvailableIngredientsScreenState createState() =>
      _AvailableIngredientsScreenState();
}

class _AvailableIngredientsScreenState
    extends State<AvailableIngredientsScreen> {
  int _selectedIndex = -1;

  List<Map<String, dynamic>> ingredientData = [];

  final List<String> _categories = [
    'Vegetables',
    'Meats',
    'Fruits',
    'Staples',
  ];

  final List<List<String>> _ingredients = [
    // Vegetables
    [
      'Mushrooms',
      'Raddish',
      'Cauliflower',
      'Broccoli',
      'Egg-plant',
      'Spinach',
      'Cucumber',
      'Bell Pepper',
      'Bitter-Gourd',
      'Tomatoes',
      'Carrots',
      'Green Beans',
      'Pumpkin',
      'Cabbage',
      'Potatoes',
      'Coriander',
    ],
    // Meats
    [
      'Chicken',
      'Pork',
      'Fish',
      'Beef',
      'Lamb',
      'Prawns',
      'Crab',
      'Clamps',
    ],
    // Fruits
    [
      'Apple',
      'Avocados',
      'Bananas',
      'Jackfruit',
      'Lemon',
      'Mango',
      'Pineapple',
      'Pomegranate',
    ],
    // Staples
    [
      'Gram Flour',
      'Wheat Flour',
      'Rice',
      'Noodle',
      'Dhal',
      'Ghee',
      'Milk',
      'Nuts',
      'Eggs',
      'Chickpeas',
      'Greenpeas',
      'Coconut',
    ],
  ];

  List<Map<String, dynamic>> _selectedIngredients = [];
  bool _showIngredients = false;

  void _onCategoryTapped(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _showIngredients = !_showIngredients;
      } else {
        _selectedIndex = index;
        _showIngredients = true;
      }
    });
  }

  void _onIngredientSelected(String ingredient) async {
    final existingIndex =
        _selectedIngredients.indexWhere((item) => item['name'] == ingredient);

    if (existingIndex == -1) {
      final DateTime? selectedDate = await _selectDate(context);
      if (selectedDate != null) {
        final Map<String, dynamic> ingredientMap = {
          'name': ingredient,
          'date': selectedDate,
        };
        _selectedIngredients.add(ingredientMap);
      }
    } else {
      _selectedIngredients.removeAt(existingIndex);
    }
    List ingredientNames =
        _selectedIngredients.map((item) => item['name']).toList();

    // Print the list of ingredient names
    print(ingredientNames);

    IngridientApi().postAvailableIngredients(ingredientNames);
    setState(() {});
    print(existingIndex);
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Ingredients'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedIndex == index;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onCategoryTapped(index);
                      },
                      child: Card(
                        elevation: isSelected ? 3 : 1,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorScheme.primary.withOpacity(0.08)
                                : colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.outlineVariant,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                isSelected
                                    ? _showIngredients
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down
                                    : null,
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: isSelected && _showIngredients
                          ? MediaQuery.of(context).size.height * 0.3
                          : 0,
                      child: isSelected && _showIngredients
                          ? Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _ingredients[index]
                                      .map(
                                        (ingredient) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _onIngredientSelected(ingredient);
                                            },
                                            child: CheckboxListTile(
                                              title: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '$ingredient ${_selectedIngredients.where((item) => item['name'] == ingredient).isNotEmpty ? '- ${_selectedIngredients.firstWhere((item) => item['name'] == ingredient)['date'].toString().substring(0, 10)}' : ''}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: _selectedIngredients
                                                                .any((element) =>
                                                                    element[
                                                                        'name'] ==
                                                                    ingredient)
                                                            ? colorScheme.primary
                                                            : colorScheme
                                                                .onSurface,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _onIngredientSelected(
                                                          ingredient);
                                                    },
                                                    icon: Icon(
                                                      Icons.calendar_today,
                                                      color: _selectedIngredients
                                                              .any((element) =>
                                                                  element[
                                                                      'name'] ==
                                                                  ingredient)
                                                          ? colorScheme.primary
                                                          : colorScheme
                                                              .onSurfaceVariant,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              value: _selectedIngredients.any(
                                                  (element) =>
                                                      element['name'] ==
                                                      ingredient),
                                              onChanged: (value) {
                                                _onIngredientSelected(
                                                    ingredient);
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              activeColor: colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    onPressed: () {
                      // Placeholder for scanner
                    },
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Scan ingredients'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      // Placeholder for recipe generation
                      if (_selectedIngredients.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Please select ingredients to generate recipes',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: colorScheme.error,
                          ),
                        );
                      } else {
                        for (final ingredient in _selectedIngredients) {
                          ingredientData.add({
                            'user': UserApi.user.id,
                            'name': ingredient['name'],
                            'expiryDate':
                                ingredient['date'].toString().substring(0, 10),
                          });
                          print(ingredient);
                        }
                        print(ingredientData);
                        IngridientApi.createBatchIngredient(
                            context, ingredientData);
                        ingredientData.clear();
                        _selectedIngredients.clear();
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save ingredients'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
