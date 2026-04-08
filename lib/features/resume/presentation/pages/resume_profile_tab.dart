import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResumeProfileTab extends StatefulWidget {
  const ResumeProfileTab({super.key});

  @override
  State<ResumeProfileTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeProfileTab> {
  int selectedTab = 0;
  final tabs = ["About", "Skills", "Experience", "Education"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topBar(),
              _actionButtons(),
              _profileCard(),
              _sectionTabs(),
              _tabContent(),

              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            "Resume Profile",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [_pill("View Resume"), _pill("Templates"), _pill("Audit CV")],
      ),
    );
  }

  Widget _pill(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _profileCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/icons/profile_img.jpg',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ramananda Sarkar",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'I am a "Software Developer"',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),

                ],
              ),
            ),
            const Icon(Icons.edit, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _sectionTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = selectedTab == i;

          return GestureDetector(
            onTap: () => setState(() => selectedTab = i),
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF020C22) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _tabContent() {
    switch (selectedTab) {
      case 0:
        return Column(
          children: [
            _aboutSection(),
            _expertiseSection(),
          ],
        );
      case 1:
        return _expertiseSection();
      case 2:
        return _placeholder("Experience Section");
      case 3:
        return _placeholder("Education Section");
      default:
        return const SizedBox();
    }
  }

  Widget _aboutSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Text(
                  "About Me (Min 500 words)",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Icon(Icons.edit, size: 18),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text("See translations", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(title, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _expertiseSection() {
    final items = [
      "Logo Design",
      "Branding Design",
      "App Design",
      "SaaS",
      "UX Design",
      "Interface Design",
      "UI Design",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        //padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: const [
                  Text(
                    "Expertise",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Chip(label: Text("+Add")),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: items
                    .map(
                      (e) =>
                          Chip(label: Text(e), backgroundColor: Colors.white),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
