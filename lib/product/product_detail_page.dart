import 'dart:async';
import 'package:flutter/material.dart';
import 'package:start_project/product/models/api/products_api.dart';
import 'package:start_project/product/view/product_details_widgets/product_details_widget.dart';
import 'package:start_project/product/view/product_details_widgets/empty_product_details_error_widget.dart';
import 'models/entities/product_data_api_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productId});
  final int productId;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Future<ProductModel>? _productDetails;

  void _getData() async {
    final details = await ProductsApi().loadDetails(productId: widget.productId);
    setState(() {
      _productDetails = Future.value(details);
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
          title: const Text('Магазин Ждуна'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder<ProductModel>(
            future: _productDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const EmptyProductDetailsPage();
              } else if (snapshot.hasError) {
                return Text('Ошибка: ${snapshot.error}');
              } else {
                final product = snapshot.data;

                if (product == null){
                  return const SizedBox.shrink();
                }
                else{
                  return ProductDetails(
                    productName: product.title ?? 'Без имени',
                    productImage: product.imageUrl ?? 'https://www.alladvertising.ru/porridge/83/101/cc0022fa79fbce43dcb67b4e40d73d2d',
                    productDescription: product.productDescription ?? 'К сожалению, описание отсутствует.',
                    productPrice: product.price,
                    productId: product.productId,
                  );
                }
              }
            },
          ),
        ),
    );
  }
}
