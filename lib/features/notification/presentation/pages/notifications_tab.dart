import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _searchBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _sectionTitle("Today"),
                  _notificationItem(
                    title:
                    "Your Resume strength score has improved after you added new skills.",
                    time: "10 min ago",
                    highlight: true,
                  ),
                  _notificationItem(
                    title:
                    "Your personal Landing page is now live and accessible to anyone.",
                    time: "50 min ago",
                  ),
                  _notificationItem(
                    title:
                    "A new Resume Template is now available to present better.",
                    time: "6 hours ago",
                  ),
                  const SizedBox(height: 16),
                  _sectionTitle("Earlier"),
                  _notificationItem(
                    title:
                    "Your Resume strength score has improved after update.",
                    time: "Yesterday",
                  ),
                  _notificationItem(
                    title:
                    "Your Landing page is now live and accessible to anyone.",
                    time: "3 days ago",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text("Notifications",
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.w600)),
          const Spacer(),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _notificationItem({
    required String title,
    required String time,
    bool highlight = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notifications,
              color: highlight ? Colors.blue : Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(fontSize: 14)),
                const SizedBox(height: 4),
                Text(time,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
