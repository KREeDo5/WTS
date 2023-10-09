import 'package:flutter/material.dart';
import 'package:start_project/product/models/api/products_api.dart';
import 'package:start_project/product/models/entities/product_data_api_model.dart';
import 'package:start_project/product/product_details_page.dart';
import 'package:start_project/views/network_image_widget.dart';
import 'package:start_project/product/view/product_list_view/product_price_widget.dart';
import 'view/product_list_view/empty_category_error_widget.dart';

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

  _drawProductInfo(String? productName, productDescription, productPrice) {
    final String name = productName ?? 'Без имени';
    if (productDescription == ' ' || productDescription == null) {
      productDescription = 'К сожалению, описание отсутствует.';
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 12 * 4,
            child: Text(
              productDescription,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ProductPriceWidget(
            productPrice: productPrice,
          ),
        ],
      ),
    );
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
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    InkWell(
                      child: NetworkImageWidget(
                        img: product.imageUrl,
                        height: 150,
                        width: 150,
                        margin: 5,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(productId: product.productId),
                          ),
                        );
                      },
                    ),
                    _drawProductInfo(product.title, product.productDescription,
                        product.price)
                  ], //children
                ),
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
            } else {
              return const EmptyCategoryPage();
            }
          }, //children
        ),
      ),
    );
  }
}
