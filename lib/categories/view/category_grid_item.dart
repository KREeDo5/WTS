import 'package:flutter/material.dart';
import 'package:start_project/views/network_image_widget.dart';
import '../../../resources/resources.dart';
import '../../product/product_list_page.dart';
import '../models/entities/category_data_api_model.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
      final id = category.categoryId;
      return GridTile(
        footer: Container(
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.inversePrimary,
          child: Text(
            category.title.toLowerCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: InkWell(
          child: NetworkImageWidget(
            img: category.imageUrl,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListPage(
                  categoryName: category.title.toLowerCase(),
                  categoryId: id,
                ),
              ),
            );
          },
        ),
      );
  }
}
