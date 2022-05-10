import 'package:flutter/material.dart';
import 'package:ftc_forum/screens/admin/category/add_new_category_screen.dart';

class AdminCategoryScreen extends StatelessWidget {
  AdminCategoryScreen({Key? key}) : super(key: key);

  List<String> dummyCategories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
    'Category 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Category'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: dummyCategories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                dummyCategories[index],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddNewCategoryScreen();
              },
            ),
          );
        },
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
