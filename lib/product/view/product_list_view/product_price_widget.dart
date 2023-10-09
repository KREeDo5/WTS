import 'package:flutter/material.dart';

class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({super.key, required this.productPrice});

  final int? productPrice;

  @override
  Widget build(BuildContext context) {
    if (productPrice == null){
      return const SizedBox.shrink();
    }
    else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$productPrice ₽',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
          )
        ],
      );
    }
  }
}