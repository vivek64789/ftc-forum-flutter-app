import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/cubits/users/profile/profile_cubit.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/models/user_model.dart';

class UserProfileScreen extends StatefulWidget {
  final String questionUserId;
  const UserProfileScreen({Key? key, required this.questionUserId})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _appBloc = BlocProvider.of<AppBloc>(context);
    final _profileCubit = BlocProvider.of<ProfileCubit>(context);
    final _questionCubit = BlocProvider.of<QuestionCubit>(context);

    _profileCubit.uidChanged(_appBloc.state.user.id);
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _profileCubit.fetchUserProfileById(widget.questionUserId),
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
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(user.name.toString()),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // width: size.width * 0.9,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height * 0.1),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.photo.toString(),
                        ),
                        radius: size.height * 0.1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: _questionCubit.fetchTotalQuestionsByUserId(
                                widget.questionUserId),
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
                              return ProfileListItem(
                                caption: "Total Posts:",
                                title: snapshot.data!.docs.length.toString(),
                              );
                            },
                          ),
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
                  ],
                ),
              ),
            ),
          );
        });
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
