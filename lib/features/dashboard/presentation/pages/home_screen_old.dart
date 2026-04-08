import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/config/theme/app_theme.dart';
import '../../../../core/network/internet_cubit.dart';

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({Key? key});

  @override
  State<HomeScreenOld> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreenOld> {
  @override
  void initState() {
    super.initState();

    // Add logic to retrieve the token from AuthBloc and initialize RoomBloc
    loadDashboardAPIs();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    loadDashboardAPIs();
  }

  loadDashboardAPIs() {
    // final authState = context.read<AuthBloc>().state;
    // if (authState is AuthAuthorized) {
    //   context
    //       .read<DashboardDataBloc>()
    //       .add(GetDashboardList(apiToken: authState.token));
    // }
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
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is InternetConnected) {
              loadDashboardAPIs();
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopView(),

            _buildMiddleView(),
            _buildCompleteButtonView(),
            // 🔹 Header Section
            _buildHeader(),

            const SizedBox(height: 16),

            // 🔹 Resume Card Section
            _buildResumeCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopView() {
    return Container(
      width: double.infinity, // full width
      decoration: BoxDecoration(
        color: AppColorTheme.primaryDark,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Top Logo
          Image.asset('assets/icons/app_logo.png', height: 28),

          const SizedBox(height: 24),
          buildWelcomeText("Mohammad Asadul"),
          const SizedBox(height: 16),
          // 🔹 Subtitle Text
          const Text(
            "Let's complete your digital profile fully and express your professional life to the world...",
            style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleView() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColorTheme.light_gray,
        borderRadius: BorderRadius.circular(16), // 🔹 smoother round
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Profile Completion Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColorTheme.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColorTheme.primaryDark,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Profile Completion',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '12% increase than last 7 days',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  // Progress indicator for profile completion
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.7, // 70%
                      color: AppColorTheme.primaryDark,
                      backgroundColor: Colors.white24,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '70%',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),
          // 🔹 Profile Viewed Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColorTheme.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: AppColorTheme.primaryDark,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Profile Viewed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '22% increase than last 7 days',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '230',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteButtonView() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColorTheme.light_gray, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🔹 Full-width Button
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Add your navigation or action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColorTheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Let's Complete",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 🔹 Completion Info Text
          const Text(
            'Your resume profile completion score is "70%"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeText(String name) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Welcome back, ',
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
          TextSpan(
            text: name,
            style: TextStyle(
              color: AppColorTheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'My Resume',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.black12),
                  ),
                ),
                child: const Text(
                  'View Resume',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Row(
            children: [
              _circleIcon(Icons.share_outlined),
              const SizedBox(width: 8),
              _circleIcon(Icons.download_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Icon(icon, size: 22),
    );
  }

  // ------------------------------------------------------
  // RESUME CARD SECTION
  Widget _buildResumeCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Profile Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/icons/ic_profile.png',
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Mohammad Asadul Islam',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'I\'m a “Product Designer”',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'Dhaka, Bangladesh',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 32),

          // 🔹 About Section
          const Text(
            'About Me',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          const Text(
            "My passion is designing digital products and creating user-friendly interfaces...",
            style: TextStyle(color: Colors.black87, height: 1.4),
          ),

          const SizedBox(height: 16),

          // 🔹 Skills
          const Text(
            'Skills (Tools)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const [
              _SkillChip('Adobe Photoshop'),
              _SkillChip('Illustrator'),
              _SkillChip('Figma'),
              _SkillChip('XD'),
            ],
          ),

          const SizedBox(height: 20),

          // 🔹 Education
          const Text(
            'Education',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          const Text(
            'Diploma @ Multimedia Services (MMSV2)\nNIT National Institute on Information Technology, 2012',
            style: TextStyle(color: Colors.black87, height: 1.4),
          ),

          const SizedBox(height: 12),

          // 🔹 Portfolio Links
          const Text(
            'Portfolio Links',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _LinkText('Behance', 'https://www.behance.net/moasisonline'),
              _LinkText('LinkedIn', 'https://www.linkedin.com/in/moasisonline'),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------
  // CUSTOM WIDGETS
  static Widget _buildBottomNavBar() {
    // You can keep your existing GNav bottom navigation here
    return SizedBox(height: 80); // placeholder for now
  }
}

class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xffF0F0F0),
      labelStyle: const TextStyle(fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class _LinkText extends StatelessWidget {
  final String title;
  final String link;

  const _LinkText(this.title, this.link);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '$title: $link',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 13,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

