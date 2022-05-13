import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/users/category/category_cubit.dart';
import 'package:ftc_forum/cubits/users/section/section_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/screens/categories/widgets/section_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sectionCubit = BlocProvider.of<SectionCubit>(context);
    final _categoryCubit = BlocProvider.of<CategoryCubit>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _categoryCubit.fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final category = QuestionCategory.fromMap(doc.data(), doc.id);

                return Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  child: SectionWidget(
                    category: category,
                    size: size,
                    sectionTitle: category.categoryName.toString(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ftc_forum/cubits/users/section/section_cubit.dart';
// import 'package:ftc_forum/models/section.dart';
// import 'package:ftc_forum/screens/categories/widgets/section_widget.dart';

// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _sectionCubit = BlocProvider.of<SectionCubit>(context);
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Categories'),
//       ),
//       body: Container(
//         child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: _sectionCubit.fetchSections(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final doc = snapshot.data!.docs[index];
//                 final section = Section.fromMap(doc.data(), doc.id);

//                 return Container(
//                   margin: EdgeInsets.only(top: size.height * 0.02),
//                   child: SectionWidget(
//                     section: section,
//                     size: size,
//                     sectionTitle: section.name.toString(),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
