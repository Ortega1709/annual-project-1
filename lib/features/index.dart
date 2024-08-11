import 'package:e_commerce/features/account/presentation/screens/account_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_discovery_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> screens = [
      ProductDiscoveryScreen(),
      //ProductSearchScreen(),
      AccountScreen()
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: currentIndex,
        onTap: (value) {
          if (value == 10) {
            context.push("/search");
          } else {
            setState(() {
              currentIndex = value;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bowlFood,
              size: 20,
            ),
            label: "Aliments",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     FontAwesomeIcons.magnifyingGlass,
          //     size: 20,
          //   ),
          //   label: "Recherche",
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_solid,
              size: 20,
            ),
            label: "Compte",
          ),
        ],
      ),
    );
  }
}
