import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/login/login_cubit.dart';
import 'package:ftc_forum/cubits/users/category/category_cubit.dart';
import 'package:ftc_forum/cubits/users/profile/profile_cubit.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/cubits/users/section/section_cubit.dart';
import 'package:ftc_forum/repositories/auth_repository.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:ftc_forum/screens/categories/categories_screen.dart';
import 'package:ftc_forum/screens/homescreen/home_screen.dart';
import 'package:ftc_forum/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: MainScreen());

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentNavigationIndex = 0;
  final screen = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => ReplyCubit(UserRepository()),
        ),
      ],
      child: HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => ReplyCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => SectionCubit(UserRepository()),
        ),
      ],
      child: CategoriesScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(context.read<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(UserRepository()),
        ),
      ],
      child: ProfileScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavigationIndex,
        onTap: (index) {
          setState(() {
            currentNavigationIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: screen[currentNavigationIndex],
    );
  }
}
