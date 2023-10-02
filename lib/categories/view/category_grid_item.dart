import 'package:flutter/material.dart';
import '../../../resources/resources.dart';
import '../../product/products_list_page.dart';
import '../models/entities/category_data_api_model.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});
  final CategoryModel category; //TODO: замена dynamic на класс категорий,

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
          child: Image.network(
            category.imageUrl,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.zhdun),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsListPage(
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
