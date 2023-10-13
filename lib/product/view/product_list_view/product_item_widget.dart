import 'package:flutter/material.dart';
import 'package:start_project/product/models/entities/product_data_api_model.dart';
import 'package:start_project/product/product_details_page.dart';
import 'package:start_project/views/network_image_widget.dart';
import 'product_price_widget.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key,
    required this.productItem
  });

  final ProductModel productItem;

  @override
  Widget build(BuildContext context) {
    final String name = productItem.title ?? 'Без имени';
    final String description = productItem.productDescription ?? 'К сожалению описание товара отсутствует';
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
              img: productItem.imageUrl,
              height: 150,
              width: 150,
              margin: 5,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailPage(productId: productItem.productId),
                ),
              );
            },
          ),
          Expanded(
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
                const SizedBox(height: 5,),
                SizedBox(
                  height: 12 * 4,
                  child: Text(
                    description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ProductPriceWidget(productPrice: productItem.price),
              ],
            ),
          ),
        ], //children
      ),
    );
  }
}