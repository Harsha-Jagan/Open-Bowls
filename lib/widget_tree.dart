import 'package:flutter/material.dart';
import 'package:frontend/pages/assistance_programs_page.dart';
import 'package:frontend/pages/donation_centers_map_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/meal_preferences.dart';
import 'package:frontend/pages/profile_page.dart';

import 'pages/diet_home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentPage = 0;
  List<Widget> pages = [
    const MealPreferences(),
    const DonationCentersMapPage(),
    const AssistanceProgramsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentPage),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.food_bank), label: 'Recipes'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Find Food'),
          NavigationDestination(icon: Icon(Icons.help), label: 'Resources'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }
}
