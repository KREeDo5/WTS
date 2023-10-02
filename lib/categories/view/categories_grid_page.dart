import 'package:flutter/material.dart';
import 'package:start_project/categories/view/category_grid_item.dart';
import '../models/entities/category_data_api_model.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.title});

  final String title;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  Future<List<CategoryModel>>? _categories;

  void _getData() async {
    final categories = await CategoryModel.loadList();
    setState(() {
      _categories = Future.value(categories);
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<List<CategoryModel>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LinearProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.blueGrey,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No categories available.');
            } else {
              final categories = snapshot.data;

              return GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: categories?.length,
                itemBuilder: (context, index) {
                  return CategoryGridItem(category: categories![index],);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

