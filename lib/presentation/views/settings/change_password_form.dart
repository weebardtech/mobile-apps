import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/theme/app_theme.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../business_logic/blocs/change_password_bloc/change_password_bloc.dart';
import '../../business_logic/blocs/change_password_bloc/change_password_state.dart';
import '../../../core/network/internet_cubit.dart';

class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  _ChangePasswordFormState();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool passToggle = true;
  bool passToggle2 = true;
  bool passToggle3 = true;
  bool isLoading = false; // Track loading state

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
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
        BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordFailure) {
              String errorMessage =
                  "Password Change failed. ${state.error.toString()}";

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
              setState(() {
                isLoading = false; // Reset loading state
              });
            }

            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password changed successfully.'),
                  backgroundColor: Colors.green,
                ),
              );
              // Automatically navigate back to the previous page
              Navigator.of(context).pop();
            }

            if (state is UnAuthorized) {
              Navigator.of(context).pop();
              Future.delayed(const Duration(seconds: 1), () {
                // BlocProvider.of<AuthBloc2>(context).add(LoggedOut());
              });
            }
          },
        ),
      ],
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            //appBar: buildAppBar(context, title: "Change Password"),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 42,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: TextFormField(
                              controller: _currentPasswordController,
                              obscureText: passToggle,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Current Password',
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggle = !passToggle;
                                    });
                                  },
                                  child: Icon(passToggle
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password should be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                            child: TextFormField(
                              controller: _newPasswordController,
                              obscureText: passToggle2,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'New Password',
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggle2 = !passToggle2;
                                    });
                                  },
                                  child: Icon(passToggle2
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password should be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: passToggle3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Confirm Password',
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggle3 = !passToggle3;
                                    });
                                  },
                                  child: Icon(passToggle3
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password should be at least 6 characters';
                                } else if (value !=
                                    _newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 45,
                                  child: state is ChangePassLoading
                                      ? const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 36.0,
                                                  width: 36.0,
                                                  child:
                                                      CupertinoActivityIndicator(),
                                                )
                                              ],
                                            ))
                                          ],
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                AppColorTheme.primary,
                                            backgroundColor:
                                                AppColorTheme.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          onPressed:
                                              onChangePasswordButtonPressed,
                                          child: const Text(
                                            "Change Password",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onChangePasswordButtonPressed() {
    if (validateForm()) {
      setState(() {
        isLoading = true; // Set loading state
      });
      final authState = context.read<AuthBloc>().state;
      if (authState is Authorized) {
        BlocProvider.of<ChangePasswordBloc>(context).add(
          ChangePasswordButtonPressed(
            apiToken: "authState.token",
            currentPassword: _currentPasswordController.text,
            newPassword: _newPasswordController.text,
          ),
        );
      }
    }
  }

  bool validateForm() {
    if (_currentPasswordController.text.isEmpty == false &&
        _currentPasswordController.text == _newPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New and Current password are same"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // Check if any field is empty and show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter data in all fields!"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (_newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password should be at least 6 characters"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    if (_confirmPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password should be at least 6 characters"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      // Check if new password and confirm password match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New password and confirm password do not match!"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }
}
