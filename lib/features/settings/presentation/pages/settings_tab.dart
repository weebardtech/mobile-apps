import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weebird_app/core/widgets/primary_button.dart';

import '../../../../core/config/routes/app_router.dart';
import '../../../../core/network/internet_cubit.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthorized) {
              Navigator.pushReplacementNamed(context, AppRouter.onboard);
            }

            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _header(),
              _profileCard(context),
              _section("Profile Settings", [
                "Basic Information",
                "Profile Photo",
                "Username",
                "Account Actions",
              ]),

              _section("Billing & Payments", [
                "Premium Plans",
                "Payment Methods",
                "Billing History",
              ]),
              _section("Notifications", [
                "Email Notifications",
                "Activity Notifications",
                "Security Alerts",
                "System Notifications",
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            "Settings",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
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

  Widget _profileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/icons/profile_img.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ramananda Sarkar",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                SizedBox(height: 16),

                PrimaryButton(
                  title: "Go Premium",
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  colorPrimary: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
                Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            itemBuilder: (_, i) {
              return ListTile(
                title: Text(items[i]),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
