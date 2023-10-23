import 'dart:async';
import 'package:flutter/material.dart';
import 'package:start_project/product/models/api/products_api.dart';
import 'package:start_project/product/view/product_details_view/empty_details_widget.dart';
import 'package:start_project/views/network_image_widget.dart';
import 'models/entities/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Future<ProductModel>? _productDetails;

  void _fetchData() async {
    final details =
        await ProductsApi().loadDetails(productId: widget.productId);
    setState(() {
      _productDetails = Future.value(details);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _drawProductName(String? productName) {
    final String name = productName ?? 'Без имени';
    return Text(
      name,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _drawProductPrice(int productPrice) {
    return Text(
      '$productPrice ₽',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.green,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _drawProductDescription(String? productDescription) {
    if (productDescription == ' ' || productDescription == null) {
      productDescription = 'К сожалению, описание отсутствует.';
    }
    return Text(productDescription);
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

              if (product == null) {
                return const SizedBox.shrink();
              } else {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    children: [
                      NetworkImageWidget(
                        img: product.imageUrl,
                        height: 300,
                      ),
                      const Divider(
                        height: 1,
                      ),
                      _drawProductName(product.title),
                      const Divider(
                        height: 1,
                      ),
                      _drawProductPrice(product.price),
                      const Divider(
                        height: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _drawProductDescription(product.productDescription),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
