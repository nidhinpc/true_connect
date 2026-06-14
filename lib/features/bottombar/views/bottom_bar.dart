import 'package:flutter/material.dart';
import 'package:true_connect/features/contacts/views/contact_page.dart';
import 'package:true_connect/features/home/views/home_page.dart';
import 'package:true_connect/features/profile/views/profile_page.dart';

class BottomBar extends StatefulWidget {
  // ✅ StatefulWidget, not StatelessWidget
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState(); // ✅ State<BottomBar>
}

class _BottomBarState extends State<BottomBar> {
  // ✅ _BottomBarState
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(), ContactPage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('True Connect')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_cal_rounded),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
