import 'package:flutter/material.dart';
import 'package:start_project/product/models/api/products_api.dart';
import 'package:start_project/product/models/entities/product_model.dart';

class ProductsDataProvider extends ValueNotifier<List<ProductModel>> {
  ProductsDataProvider({required this.categoryId}) : super([]);
  int categoryId;

  ProductsApi api = ProductsApi();

  bool isLoading = false;
  bool allDataLoaded = false;

  void Function(String text)? textCallBack;

  Future<void> loadNextItems() async {
    if (isLoading || allDataLoaded) return;

    isLoading = true;
    notifyListeners();

    try {
      final productList = await api.loadList(
        categoryId: categoryId,
        offSet: value.length,
      );
      if (productList.isEmpty) {
        allDataLoaded = true;
        textCallBack!('Все продукты были загружены.');
      } else {
        value.addAll(productList);
      }
    } catch (error) {
      print('Что-то пошло не так');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    if (isLoading) return;

    value.clear();
    allDataLoaded = false;
    notifyListeners();
    await loadNextItems();
  }
}

