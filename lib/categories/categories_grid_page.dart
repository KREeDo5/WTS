import 'package:flutter/material.dart';
import 'package:start_project/categories/models/categories_provider.dart';
import 'package:start_project/categories/view/category_grid_item.dart';
import 'models/entities/category_model.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.title});

  final String title;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final scrollController = ScrollController();
  late CategoriesDataProvider categoryDataProvider;

  @override
  void initState() {
    super.initState();
    categoryDataProvider = CategoriesDataProvider();
    categoryDataProvider.textCallBack = (text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    };
    scrollController.addListener(_scrollListener);
    categoryDataProvider.loadNextItems();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      categoryDataProvider.loadNextItems();
    }
  }

  Future<void> _refresh() async {
    categoryDataProvider.reload();
  }

  @override
  void dispose() {
    scrollController.dispose();
    categoryDataProvider.dispose();
    super.dispose();
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
        child: RefreshIndicator(
          onRefresh: _refresh,
          child:ValueListenableBuilder<List<CategoryModel>>(
            valueListenable: categoryDataProvider,
            builder: (context, categoryList, child) {
                return GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: categoryList.length + ((categoryDataProvider.isLoading) ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < categoryList.length) {
                      final category = categoryList[index];
                      return CategoryGridItem(category: category,);
                    } else if (categoryDataProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Placeholder();
                    }
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}

