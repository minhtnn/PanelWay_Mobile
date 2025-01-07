import 'package:flutter/material.dart';

class BottomBarWidget extends StatefulWidget {
  final List<Map<String, dynamic>> list;
  const BottomBarWidget({super.key, required this.list});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blueGrey,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: widget.list.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon']),
          label: item['page'].toString(),
        );
      }).toList(),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
