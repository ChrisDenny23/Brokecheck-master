// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: NavigationBar(
              height: 60,
              backgroundColor: Colors.white,
              elevation: 0,
              indicatorColor:
                  Colors.green.withOpacity(0.2), // ✅ Softer highlight
              indicatorShape: RoundedRectangleBorder(
                // ✅ Ensures proper centering
                borderRadius: BorderRadius.circular(20),
              ),
              selectedIndex: selectedIndex,
              onDestinationSelected: onItemTapped,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              animationDuration:
                  const Duration(milliseconds: 300), // ✅ Smooth transition
              destinations: [
                _buildNavItem(Icons.home_rounded),
                _buildNavItem(Icons.subscriptions_rounded),
                _buildNavItem(Icons.credit_card_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon) {
    return NavigationDestination(
      icon: Padding(
        padding:
            const EdgeInsets.only(top: 3), // ✅ Adjusted padding for centering
        child: Icon(
          icon,
          size: 30,
          color: Colors.black87,
        ),
      ),
      selectedIcon: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Icon(
          icon,
          size: 30, // ✅ Slightly bigger when selected
          color: Colors.green.shade800,
        ),
      ),
      label: '',
    );
  }
}
