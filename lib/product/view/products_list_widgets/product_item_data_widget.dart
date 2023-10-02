import 'package:flutter/material.dart';

import 'Image_widget.dart';
import 'product_price_widget.dart';

class ProductItemData extends StatelessWidget {
  const ProductItemData({super.key,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productId
  });

  final String productImage;
  final String productName;
  final String productDescription;
  final int productPrice;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          ImageWidget(img: productImage, productId: productId),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
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
                    productDescription,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ProductPriceWidget(productPrice: productPrice),
              ],
            ),
          ),
        ], //children
      ),
    );
  }
}
