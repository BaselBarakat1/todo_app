import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/add_task_bootom_sheet.dart';
import 'package:todo_app/ui/home/settings_tab/settings_tab.dart';
import 'package:todo_app/ui/home/tasks_list_tab/tasks_list_tab.dart';

class HomeScreen extends StatefulWidget {
static const String routeName = 'Home_Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex = 0;

List<Widget> tabs = [
  tasksListTab(),
  settingsTab(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 52),
            child: Text('To Do List')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
       showAddTaskbottomSheet();

      },child: Icon(Icons.add,color: Colors.white,),
        shape: StadiumBorder(
            side: BorderSide(width: 4,color: Colors.white)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted_outlined,size: 33),label:'Tasks List' ),
            BottomNavigationBarItem(icon: Icon(Icons.settings,size: 33),label: 'Settings')
          ],
          showUnselectedLabels: false,
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  void showAddTaskbottomSheet() {
    showModalBottomSheet(context: context, builder:(context) => addTaskBottomSheet(),);
  }
}
