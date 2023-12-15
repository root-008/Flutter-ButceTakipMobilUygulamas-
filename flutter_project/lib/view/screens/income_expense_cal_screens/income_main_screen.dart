import 'package:flutter/material.dart';
import 'package:flutter_project/view/screens/income_expense_cal_screens/income_home_screen.dart';
import 'package:flutter_project/view/screens/income_expense_cal_screens/income_overwiew_screen.dart';


class IncomeMain extends StatefulWidget{
  const IncomeMain({super.key});

  @override
  State<StatefulWidget> createState() => IncomeMainState();

}

class IncomeMainState extends State {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    IncomeHome(),
    IncomeOverWiew(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Harcama Tavsiyeleri',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        // Animasyon için kullanılan tema
        selectedIconTheme: const IconThemeData(color: Colors.purple, size: 30),
        unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 24),
        selectedLabelStyle: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
      )

    );
  }

}