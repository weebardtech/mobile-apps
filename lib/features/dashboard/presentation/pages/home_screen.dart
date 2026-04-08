import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/config/theme/app_theme.dart';
import '../../../../core/network/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        top: true,
        child: MultiBlocListener(
          listeners: [
            BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetDisconnected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No Internet Connection!"),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topBar(),
                const SizedBox(height: 10),
                _welcomeText(),
                const SizedBox(height: 10),
                _statsGrid(),

                _buildResumeCard2(context),

                _buildResumeCard(context),
              ],
            ),
          ),
        ),
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

  // ------------------------------------------------------
  // RESUME CARD SECTION
  Widget _buildResumeCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
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

Widget _topBar() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Row(
      children: [
        Image.asset('assets/logo/logo.png', height: 32),
        const Spacer(),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Icon(Icons.search),
        ),
      ],
    ),
  );
}

Widget _welcomeText() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: 22, color: Colors.grey),
        children: const [
          TextSpan(text: "Good Afternoon, "),
          TextSpan(
            text: "Mohammad",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

Widget _statsGrid() {
  return GridView.count(
    crossAxisCount: 2,
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
    crossAxisSpacing: 6,
    mainAxisSpacing: 6,
    childAspectRatio: 1.2,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: const [
      _StatCard(title: "Resume Score Strength", value: "70%"),
      _StatCard(title: "Resume Audit Strength", value: "100/00"),
      _StatCard(title: "Profile Viewed", value: "26"),
      _StatCard(title: "Resume Downloaded", value: "230"),
    ],
  );
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_upward, size: 14, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    "12%",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildResumeCard2(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Column(
      children: [
        // 🔵 Profile completion card
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColorTheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Profile ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextSpan(
                      text: "55%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " Let's Complete",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 46,
                width: 46,
                decoration: const BoxDecoration(
                  color: Color(0xFF020C22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ⚪ Resume action card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              // View Resume Button
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF020C22),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "View resume",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 30),

              _circleIcon(Icons.print),
              _circleIcon(Icons.share),
              _circleIcon(Icons.download),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _circleIcon(IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.grey),
    ),
  );
}
