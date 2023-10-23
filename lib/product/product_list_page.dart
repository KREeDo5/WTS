import 'package:flutter/material.dart';
import 'package:start_project/product/models/entities/product_model.dart';
import 'package:start_project/product/models/product_provider.dart';
import 'package:start_project/product/view/product_list_view/product_item_widget.dart';
import 'view/product_list_view/empty_category_widget.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final int categoryId;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final scrollController = ScrollController();
  late ProductDataProvider productDataProvider;

  @override
  void initState() {
    super.initState();
    productDataProvider = ProductDataProvider(categoryId: widget.categoryId);
    productDataProvider.textCallBack = (text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    };
    scrollController.addListener(_scrollListener);
    productDataProvider.loadNextItems();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      productDataProvider.loadNextItems();
    }
  }

  Future<void> _refresh() async {
    productDataProvider.reload();
  }

  @override
  void dispose() {
    scrollController.dispose();
    productDataProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.categoryName),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ValueListenableBuilder<List<ProductModel>>(
            valueListenable: productDataProvider,
            builder: (context, productList, child) {
              return ListView.builder(
                controller: scrollController,
                itemCount: productList.length + ((productDataProvider.isLoading) ? 1 : 0),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                itemBuilder: (context, index) {
                  if (index < productList.length) {
                    final product = productList[index];
                    return ProductListItem(productItem: product,);
                  } else if (productDataProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const EmptyCategoryPage();
                  }
                }, //children
              );
            },
          ),
        ),
      ),
    );
  }
}
