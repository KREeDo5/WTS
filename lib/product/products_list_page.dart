import 'package:flutter/material.dart';
import 'package:start_project/product/models/api/products_api.dart';
import 'package:start_project/product/models/entities/product_data_api_model.dart';
import 'package:start_project/product/view/products_list_widgets/product_item_data_widget.dart';
import 'view/products_list_widgets/empty_category_error_widget.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final int categoryId;

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final scrollController = ScrollController();
  int setNumber = 0;
  List<ProductModel> products = [];
  bool isLoading = false;
  bool hasMoreData = true;

  void _getData() async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    final productList = await ProductsApi()
        .loadList(categoryId: widget.categoryId, offSet: setNumber);

    setState(() {
      products.addAll(productList);
      isLoading = false;
      if (productList.length < 15) {
        hasMoreData = false;
        print('that is all data');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _getData();
  }

  void _scrollListener() {
    const int limitSet = 15;
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (hasMoreData == true)) {
      setNumber = setNumber + limitSet;
      _getData();
    }
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
        child: ListView.builder(
          controller: scrollController,
          itemCount: (isLoading || !hasMoreData)
              ? products.length + 1
              : products.length,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          itemBuilder: (context, index) {
            if (index < products.length) {
              final product = products[index];
              return ProductItemData(
                productImage: product.imageUrl ??
                    'https://www.alladvertising.ru/porridge/83/101/cc0022fa79fbce43dcb67b4e40d73d2d',
                productName: product.title ?? 'Без имени',
                productDescription: product.productDescription ??
                    'К сожалению, описание отсутствует.',
                productPrice: product.price,
                productId: product.productId,
              );
            } else if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (products.isNotEmpty) {
              return const Center(
                child: Text(
                  'это все товары',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              );
            }
            else {
              return const EmptyCategoryPage();
            }
          }, //children
        ),
      ),
    );
  }
}
