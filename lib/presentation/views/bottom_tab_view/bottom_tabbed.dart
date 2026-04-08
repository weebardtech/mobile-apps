import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomTabbed extends StatefulWidget {
  final List<Widget> screen;

  const BottomTabbed({super.key, required this.screen});

  @override
  State<BottomTabbed> createState() => _BottomTabbedState();
}

class _BottomTabbedState extends State<BottomTabbed> {
  int _selectedIndex = 0;

  final icons = const [
    'assets/icons/ic_home.svg',
    'assets/icons/ic_resume.svg',
    'assets/icons/ic_notification.svg',
    'assets/icons/ic_settings.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: widget.screen),
      bottomNavigationBar: Container(
        height: 80,
        margin: EdgeInsets.only(left: 16.0,right: 16.0, bottom: 12.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF071B3F), Color(0xFF020C22)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(icons.length, (i) {
            final selected = _selectedIndex == i;

            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: selected ? 56 : 46,
                width: selected ? 56 : 46,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  icons[i],
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    selected ? const Color(0xFF071B3F) : Colors.white70,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
