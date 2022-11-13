import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p1_app/auth/bloc/auth_bloc.dart';
import 'package:p1_app/login/form_body_firebase.dart';
import 'package:p1_app/login/login_page.dart';
import 'package:p1_app/pages/take_audioPage.dart';

import 'package:p1_app/providers/animation_provider.dart';
import 'package:p1_app/providers/favoritessongs_provider.dart';
import 'package:p1_app/providers/recordAud_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc()..add(VerifyAuthEvent()),
      ),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnimationProvider()),
        ChangeNotifierProvider(create: (context) => RecordAudProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteSongProvider()),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return take_audioPage();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
