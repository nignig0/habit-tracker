import 'package:flutter/material.dart';
import 'package:outings/screens/calendar.dart';
import 'package:outings/screens/home.dart';

class KanbanButtonAppBar extends StatefulWidget {
 
  int pageIndex;
  KanbanButtonAppBar({required this.pageIndex});

  @override
  _KanbanButtonAppBarState createState() => _KanbanButtonAppBarState();
}

class _KanbanButtonAppBarState extends State<KanbanButtonAppBar> {
  @override
  Widget build(BuildContext context) {
    

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      backgroundColor: Colors.transparent,

      onTap: (int index){
        

        if(index == 0){
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_)=> HomeScreen()));
        }else if(index == 1){
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_)=> CalendarScreen()));
        }
      },

      selectedIconTheme: IconThemeData(color: Color(0xFF06102c), size: 37),
      unselectedIconTheme: IconThemeData(color: Color(0xFFdadbda), size: 35),
      currentIndex: widget.pageIndex,

      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home'
        ), 

        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_rounded), 
          label: 'Tasks'
        ), 

        

      ],
      
    );
  }
}