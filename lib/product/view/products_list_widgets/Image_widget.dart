import 'package:flutter/material.dart';
import '../../../../resources/resources.dart';
import '../../../product/product_detail_page.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.img, required this.productId});

  final String img;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 150,
      height: 150,
      child: InkWell(
        child: Image.network(
          img,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.zhdun),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(productId: productId),
            ),
          );
        },
      ),
    );
  }
}