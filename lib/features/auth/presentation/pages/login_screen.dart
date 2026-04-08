import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weebird_app/core/config/theme/app_theme.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:weebird_app/core/widgets/primary_button.dart';

import '../../../../core/config/routes/app_router.dart';
import '../../../../core/network/internet_cubit.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  final String email;

  const LoginScreen({super.key, required this.email});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hide = true;
  bool isLoading = false;
  late TextEditingController emailCtrl;
  final passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authorized) {
              Navigator.pushReplacementNamed(context, AppRouter.home);
            }

            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AuthLoading) {
              isLoading = true;
            }
          },
        ),
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetDisconnected) {
              String errorMessage = "No Internet Connection!";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You've a password to\nget in!",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColorTheme.primary,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.onboard);
                      },
                      child: const Text("Register now"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: passwordCtrl,
                  obscureText: hide,
                  decoration: InputDecoration(
                    hintText: "**********",
                    suffixIcon: IconButton(
                      icon: Icon(
                        hide ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => hide = !hide),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Checkbox(value: false, onChanged: (_) {}),
                    const Text("Forget Password? Then login with OTP"),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: PrimaryButton(
                    title: "Log in",
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginRequested(emailCtrl.text, passwordCtrl.text),
                      );
                    },

                    isLoading: isLoading,
                    colorPrimary: false,
                  ),
                ),

                const Spacer(),

                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'By clicking "Register now/Login" you agree to our ',
                      ),
                      TextSpan(
                        text: "Terms.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: " Learn how we process your data in our "),
                      TextSpan(
                        text: "privacy policy.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
