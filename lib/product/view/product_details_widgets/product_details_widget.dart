import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key,
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
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final String name = widget.productName;
    final String img = widget.productImage;
    String description = widget.productDescription;
    final int price = widget.productPrice;

    if (description == ' '){
      description = 'К сожалению, описание отсутствует. Был только пробел))';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            width: double.infinity,
            height: 300,
            child: Image.network(
              img,
              errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.zhdun),
            ),
          ),
          Divider(height: 1,),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(height: 1,),
          Text(
            '$price ₽',
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(height: 1,),
          SizedBox(height: 20,),
          Text(description),
        ],
      ),
    );
  }
}
