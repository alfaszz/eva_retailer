import 'package:flutter/material.dart';
import 'package:retailerapp/Nav/Bookings.dart';
import 'package:retailerapp/Nav/profile.dart';
import 'package:retailerapp/Nav/requests.dart';
import 'package:retailerapp/Nav/wallet.dart';
import 'package:retailerapp/reports.dart';
class Navigation extends StatefulWidget {
  final int index;
  const Navigation({Key? key, required this.index}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex=0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      Boookings(),
      Reports(),
      Profile(),
      Wallet(),
    ];

    return Scaffold(
        body: pages.elementAt(selectedIndex),
    bottomNavigationBar: BottomNavigationBar(
    selectedFontSize: 15,
    currentIndex: selectedIndex,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blue.shade600,

    onTap: _onItemTapped,
    items: [
      BottomNavigationBarItem(
    icon: Icon(Icons.receipt_long),
    label: 'Bookings',),

      BottomNavigationBarItem(
        icon: Icon(Icons.file_copy),
        label: 'Reports',),

      BottomNavigationBarItem(
        icon: Icon(Icons.electric_car_outlined),
        label: 'Profile',),

      BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on),
        label: 'Wallet',),


    ],)


    );
  }
}
