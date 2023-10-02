import 'package:flutter/material.dart';
import 'package:start_project/resources/resources.dart';

class EmptyProductDetailsPage extends StatelessWidget {
  const EmptyProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Информация о товаре сейчас недоступна =(',textAlign: TextAlign.center,),
        const SizedBox(height: 10,),
        const Text('В скором времени мы её добавим и ждун будет счастлив!', textAlign: TextAlign.center,),
        const SizedBox(height: 10,),
        Image.asset(AppImages.zhdun),
      ],
    );
  }
}