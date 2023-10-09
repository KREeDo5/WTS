import 'package:flutter/material.dart';
import '../../resources/resources.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({super.key, required this.img, this.width, this.height, this.margin});

  final String? img;
  final double? width;
  final double? height;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin ?? 0),
      width: width,
      height: height,
      child: Image.network(
          img ?? 'https://www.alladvertising.ru/porridge/83/101/cc0022fa79fbce43dcb67b4e40d73d2d',
          errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.zhdun),
          fit: BoxFit.fill,
      ),
    );
  }
}