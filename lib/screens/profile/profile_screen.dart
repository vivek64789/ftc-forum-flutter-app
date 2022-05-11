import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/category_cubit.dart';
import 'package:ftc_forum/cubits/admin/section/section_cubit.dart';
import 'package:ftc_forum/cubits/login/login_cubit.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';
import 'package:ftc_forum/screens/admin/category/admin_category_screen.dart';
import 'package:ftc_forum/screens/admin/section/admin_section_screen.dart';
import 'package:ftc_forum/widgets/avatar_image.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginCubit>().fetchRole(context.read<AppBloc>().state.user.id);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(size.width * 0.03),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.height * 0.01),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AvatarImage(
                      height: size.height * 0.10,
                      profileUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png',
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bibekanand Kushwaha",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        "vivek@gmail.com",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.all(size.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileListItem(
                      caption: "DOB:",
                      title: "2022-02-22",
                    ),
                    ProfileListItem(
                      caption: "Email",
                      title: "vivek@gmail.com",
                    ),
                    ProfileListItem(
                      caption: "Phone",
                      title: "9818821313",
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              // divider
              context.read<LoginCubit>().state.isAdmin
                  ? AdminSettings(size: size)
                  : Container(),

              RoundedButton(
                text: "Manage Settings",
                press: () {
                  setState(() {});
                },
              ),
              RoundedButton(
                text: "Logout",
                press: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminSettings extends StatelessWidget {
  const AdminSettings({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.grey[300],
        ),
        const Text("Admin Settings"),
        SizedBox(height: size.height * 0.01),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider(
                    create: (_) => CategoryCubit(
                      AdminRepository(),
                    ),
                    child: AdminCategoryScreen(),
                  );
                },
              ),
            );
          },
          child: const Text("Manage Categories"),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider(
                    create: (_) => SectionCubit(
                      AdminRepository(),
                    ),
                    child: AdminSectionScreen(),
                  );
                },
              ),
            );
          },
          child: const Text("Manage Sections"),
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}

class ProfileListItem extends StatelessWidget {
  String title;
  String caption;
  ProfileListItem({
    Key? key,
    required this.title,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}
