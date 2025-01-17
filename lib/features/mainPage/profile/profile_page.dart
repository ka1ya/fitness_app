import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platy/features/bloc/platy_bloc_bloc.dart';
import 'package:platy/features/login/login_page.dart';
import 'package:platy/features/mainPage/profile/profile_change_filled.dart';
import 'package:platy/features/mainPage/profile/profile_edit_page.dart';
import 'package:platy/features/pro_version/pro_version_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = const FlutterSecureStorage();
  String? email;
  String? password;
  
  String? emailText;
  String? profileImage;
  String? name;

  ImageProvider? backgroundImage;
  String? customImageFile;
  XFile? imageFile;

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient:
        const LinearGradient(colors: [Color(0xFF59A7A7), Color(0xFFAFCD6D)]),
    border: Border.all(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecorationLog = BoxDecoration(
    gradient: const LinearGradient(colors: [
      Color.fromRGBO(252, 108, 76, 1),
      Color.fromRGBO(252, 108, 76, 1)
    ]),
    border: Border.all(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(32),
  );

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlatyBloc>(context).add(ProfileDataEvent({}));
    _loadCredentials();
    //profileData;
  }

  void _loadCredentials() async {
    password = await storage.read(key: 'password');
    setState(() {
      password = password;
    });
  }

  Future openGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      print('Image URI: ${imageFile!.path}');
      PlatyBloc platyBloc = BlocProvider.of<PlatyBloc>(context);
      platyBloc.add(ProfileImagePostEvent(imageFile!));
    } else {
      print('User didn\'t pick an image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlatyBloc, PlatyBlocState>(
        builder: (context, state) {
          if (state is ProfileIncludesDataState) {
            Map<String, dynamic> profileData = state.profilePageData;
            //PlatyBloc platyBloc = BlocProvider.of<PlatyBloc>(context);
            //setState(() { });
            emailText = profileData['user_email'];
            profileImage = profileData['photo'];
            name = profileData['name'];
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          openGallery(); // This is where you handle the tap event
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          backgroundImage: profileImage != null
                              ? NetworkImage(
                                  profileImage as String,
                                ) as ImageProvider<Object>?
                              : const AssetImage(
                                  'assets/images/user-logo-image.png',
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name.toString(),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        emailText.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileEditPage()),
                                  );
                                },
                                child: Container(
                                  height: 52.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: kGradientBoxDecoration,
                                  child: Container(
                                    decoration: kInnerDecoration,
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: Image.asset(
                                            'assets/images/profile_edit_vector.png',
                                            height: 24,
                                          ),
                                        ),
                                        const Text(
                                          "Edit Profile",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileChangeFilledPage()),
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(1.0, 1.0),
                                      colors: [
                                        Color(0xFF59A7A7),
                                        Color(0xFFAFCD6D)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Recalculation of values',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'Gilroy',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProVersionPage()),
                              );
                            },
                            child: Container(
                              height: 52.0,
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: kGradientBoxDecoration,
                              child: Container(
                                decoration: kInnerDecoration,
                                child: const Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Сhange my subscription plan",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 130),
                          GestureDetector(
                            onTap: () {
                              _showCupertinoAlertDialog(context,
                                  email: emailText!,
                                  password: password.toString());
                            },
                            child: Container(
                              height: 52.0,
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: kGradientBoxDecorationLog,
                              child: Container(
                                decoration: kInnerDecoration,
                                child: const Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Log Out",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              _showCupertinoAlertDialogDelete(context,
                                  email: emailText,
                                  password: password);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 52.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                gradient: const LinearGradient(
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(1.0, 1.0),
                                  colors: [
                                    Color.fromRGBO(252, 108, 76, 1),
                                    Color.fromRGBO(252, 108, 76, 1)
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Delete account',
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Gilroy',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCupertinoAlertDialog(BuildContext context,
      {required String email, required String password}) {
    PlatyBloc platyBloc = BlocProvider.of<PlatyBloc>(context);

    Map<String, dynamic> logOutData = {
      "email": email,
      "password": password,
    };
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Log out ?'),
          content:
              const Text('Are you sure you want to log out of your account?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                platyBloc.add(LogOutEvent(logOutData));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()));
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  void _showCupertinoAlertDialogDelete(BuildContext context,
      {required email, String? password}) {
    PlatyBloc platyBloc = BlocProvider.of<PlatyBloc>(context);

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete account ?'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()));
                await Future.delayed(const Duration(seconds: 1));
                platyBloc.add(DeleteAccountEvent(const {}));
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
