import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/admin_category_cubit.dart';
import 'package:ftc_forum/cubits/admin/section/admin_section_cubit.dart';
import 'package:ftc_forum/cubits/login/login_cubit.dart';
import 'package:ftc_forum/cubits/users/profile/profile_cubit.dart';
import 'package:ftc_forum/models/user_model.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';
import 'package:ftc_forum/screens/admin/category/admin_category_screen.dart';
import 'package:ftc_forum/screens/admin/questions/admin_view_questions_screen.dart';
import 'package:ftc_forum/screens/admin/replies/admin_view_replies_screen.dart';
import 'package:ftc_forum/screens/admin/section/admin_section_screen.dart';
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
    final _appBloc = BlocProvider.of<AppBloc>(context);
    final _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.uidChanged(_appBloc.state.user.id);
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
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _profileCubit.fetchUserProfile(),
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
              final user = User.fromJson(snapshot.data!.data());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _profileCubit.uploadImage(context);
                        },
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return state.status == ProfileStatus.loading
                                ? const CircularProgressIndicator()
                                : Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user.photo.toString().isEmpty
                                            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png"
                                            : user.photo.toString(),
                                      ),
                                      radius: size.height * 0.04,
                                    ),
                                  );
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name.toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            user.email.toString(),
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
                          title: user.dob.toString(),
                        ),
                        ProfileListItem(
                          caption: "Email",
                          title: user.email.toString(),
                        ),
                        ProfileListItem(
                          caption: "Phone",
                          title: user.phone.toString(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  // divider
                  user.role.toString() == 'admin'
                      ? AdminSettings(size: size)
                      : Container(),

                  RoundedButton(
                    text: "Logout",
                    press: () {
                      Navigator.of(context).popUntil((route) => false);
                      context.read<AppBloc>().add(AppLogoutRequested());
                    },
                  ),
                ],
              );
            },
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
                    create: (_) => AdminCategoryCubit(
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
                    create: (_) => AdminSectionCubit(
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
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider(
                    create: (_) => AdminCategoryCubit(
                      AdminRepository(),
                    ),
                    child: AdminViewQuestionsScreen(),
                  );
                },
              ),
            );
          },
          child: const Text("Manage Questions"),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider(
                    create: (_) => AdminCategoryCubit(
                      AdminRepository(),
                    ),
                    child: AdminViewRepliesScreen(),
                  );
                },
              ),
            );
          },
          child: const Text("Manage Replies"),
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
