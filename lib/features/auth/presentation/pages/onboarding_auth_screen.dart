import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weebird_app/core/utils/validators.dart';
import 'package:weebird_app/core/widgets/primary_button.dart';

import '../../../../core/config/routes/app_router.dart';
import '../../../../core/config/theme/app_theme.dart';

class OnboardingAuthScreen extends StatefulWidget {
  const OnboardingAuthScreen({super.key});

  @override
  State<OnboardingAuthScreen> createState() => _OnboardingAuthScreenState();
}

class _OnboardingAuthScreenState extends State<OnboardingAuthScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool isLoginSelected = true;
  bool showSocialLogin = true; // first screen shows OR + socials

  final titles = [
    "Effortless Resume",
    "Smart Networking",
    "NoCode Biopage",
    "Flexible Templates",
    "Flexible Templates",
    "Connect Right Jobs",
    "Mentor Guidance",
  ];

  final images = [
    "assets/onboard/onboard_1.svg",
    "assets/onboard/onboard_2.svg",
    "assets/onboard/onboard_3.svg",
    "assets/onboard/onboard_4.svg",
    "assets/onboard/onboard_5.svg",
    "assets/onboard/onboard_6.svg",
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            /// ─────────── FIXED LOGO ───────────
            SizedBox(height: h * 0.015),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/logo/logo.png', height: 28),
              ),
            ),

            const SizedBox(height: 10),

            /// ─────────── SCROLLABLE BODY ───────────
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: h * 0.05),

                    SizedBox(
                      height: h * 0.32,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() => currentIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: h * 0.25,
                                child: SvgPicture.asset(
                                  images[index],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(height: h * 0.012),
                              Text(
                                titles[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentIndex == index ? 10 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.black
                                : Colors.black26,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ─────────── BOTTOM LOGIN / REGISTER CARD ───────────
                    Container(
                      padding: const EdgeInsets.all(22),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: AppColorTheme.primaryDark,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Form(key: _formKey, child: _inputField()),

                          SizedBox(height: h * 0.02),

                          if (!isLoginSelected) ...[
                            _orSocialLogin(),
                            SizedBox(height: h * 0.025),
                            _registerButton(),
                          ] else ...[
                            _loginButton(),
                          ],

                          SizedBox(height: h * 0.04),
                          _loginRegisterSwitch(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );

  }

  Widget _inputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: emailCtrl,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Enter Email Address",
          border: InputBorder.none,
        ),
        // validator: Validators.email,
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: PrimaryButton(
        title: "Start With Login",
        onPressed: () {
          final error = Validators.email(emailCtrl.text);
          if (error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error)));
            return;
          }
          Navigator.pushNamed(
            context,
            AppRouter.login,
            arguments: emailCtrl.text,
          );
        },
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,

      child: PrimaryButton(
        title: "Let's Begin",
        onPressed: () {
          final error = Validators.email(emailCtrl.text);
          if (error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error)));
            return;
          }
          Navigator.pushNamed(
            context,
            AppRouter.register,
            arguments: emailCtrl.text,
          );
        },
      ),
    );
  }

  Widget _orSocialLogin() {
    return Column(
      children: [
        const SizedBox(height: 18),

        Row(
          children: const [
            Expanded(child: Divider(color: Colors.white24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text("or", style: TextStyle(color: Colors.white70)),
            ),
            Expanded(child: Divider(color: Colors.white24)),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialBtn("G"),
            const SizedBox(width: 16),
            _socialBtn("in"),
            const SizedBox(width: 16),
            //_socialBtn(""),
            _socialBtn(FontAwesomeIcons.apple),
          ],
        ),
      ],
    );
  }

  Widget _socialBtn(dynamic icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: icon is IconData
          ? Icon(icon, color: const Color(0xFF2563EB), size: 20)
          : Text(
              icon,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2563EB),
              ),
            ),
    );
  }

  Widget _loginRegisterSwitch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          // LOGIN
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isLoginSelected = true);
              },
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: isLoginSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: isLoginSelected ? Color(0xFF041C3F) : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // REGISTER
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isLoginSelected = false);
              },
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: !isLoginSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Registration",
                  style: TextStyle(
                    color: !isLoginSelected
                        ? const Color(0xFF041C3F)
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
