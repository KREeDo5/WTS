import 'package:flutter/material.dart';
import 'package:start_project/categories/models/api/categories_api.dart';
import 'package:start_project/categories/models/entities/category_model.dart';

class CategoriesDataProvider extends ValueNotifier<List<CategoryModel>> {
  CategoriesDataProvider() : super([]);

  CategoriesApi api = CategoriesApi();

  bool isLoading = false;
  bool allDataLoaded = false;

  void Function(String text)? textCallBack;

  Future<void> loadNextItems() async {
    if (allDataLoaded){
      textCallBack!('Все категории были загружены.');
    }
    if (isLoading || allDataLoaded) return;

    isLoading = true;
    notifyListeners();

    try {
      final categoryList = await api.loadList(
        offSet: value.length,
      );
      if (categoryList.isEmpty){
        allDataLoaded = true;
      } else {
        value.addAll(categoryList);
      }
      allDataLoaded = true; //из-за отсутствия параметра offSet принудительно сообщаю о полной загрузке данных
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
