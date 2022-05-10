import 'package:flutter/material.dart';

class AddNewCategoryScreen extends StatelessWidget {
  const AddNewCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('AddNewCategoryScreen'),
        ),
      ),
    );
  }
}
