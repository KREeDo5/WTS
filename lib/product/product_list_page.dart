import 'package:flutter/material.dart';
import 'package:start_project/product/models/entities/product_data_api_model.dart';
import 'package:start_project/product/models/product_data_provider.dart';
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
  late ProductDataProvider productDataProvider;

  @override
  void initState() {
    super.initState();
    productDataProvider = ProductDataProvider(categoryId: widget.categoryId);
    scrollController.addListener(_scrollListener);
    productDataProvider.loadNextItems();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      productDataProvider.loadNextItems();
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
  Future<void> _refresh() async {
    productDataProvider.reload();
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
                itemCount: productList.length + ((productDataProvider.isLoading||productDataProvider.allDataLoaded) ? 1 : 0),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                itemBuilder: (context, index) {
                  if (index < productList.length) {
                    final product = productList[index];
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
                                  builder: (context) => ProductDetailPage(
                                      productId: product.productId),
                                ),
                              );
                            },
                          ),
                          _drawProductInfo(product.title,
                              product.productDescription, product.price)
                        ], //children
                      ),
                    );
                  } else if (productDataProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (productDataProvider.allDataLoaded) {
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
              );
            },
          ),
        ),
      ),
    );
  }
}
