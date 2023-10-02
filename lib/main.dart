import 'package:flutter/material.dart';
import 'package:start_project/categories/view/categories_grid_page.dart';

//TODO: splash_screen
//TODO: bottomNavigationBar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'start',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CategoriesPage(title: 'Магазин Ждуна'),
    );
  }
}
