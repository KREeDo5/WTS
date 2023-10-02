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
  Future<List<ProductModel>>? _products;
  void _getData() async {

    final categories = await ProductsApi().loadList(categoryId: widget.categoryId);
    setState(() {
      _products = Future.value(categories);

    });
  }

  @override
  void initState() {
    super.initState();
    //
    _getData();
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
        child: FutureBuilder<List<ProductModel>>(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.blueGrey,
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const EmptyCategoryPage();
            } else if (snapshot.hasError) {
              return Text('Ошибка: ${snapshot.error}');
            } else {
              final products = snapshot.data;

              return ListView.builder(
                controller: scrollController,
                itemCount: products?.length,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                itemBuilder: (context, index) {
                  final product = products?[index];
                  if (product == null){
                    return const SizedBox.shrink();
                  }
                  else{
                    return ProductItemData(
                      productImage: product.imageUrl ?? 'https://www.alladvertising.ru/porridge/83/101/cc0022fa79fbce43dcb67b4e40d73d2d',
                      productName: product.title ?? 'Без имени',
                      productDescription: product.productDescription ?? 'К сожалению, описание отсутствует.',
                      productPrice: product.price,
                      productId: product.productId,
                    );
                  }
                }, //children
              );
            }
          },
        ),
      ),
    );
  }
}
