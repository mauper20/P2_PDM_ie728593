import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p1_app/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/giphy.gif"),
            opacity: 0.3,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 48),
                  const Text(
                    "Iniciar sesión",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(GoogleAuthEvent());
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                    ),
                    label: const Text("Iniciar sesión con Google"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        0xFF,
                        0xDC,
                        0x4E,
                        0x41,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
