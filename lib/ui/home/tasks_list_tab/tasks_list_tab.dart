import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider/auth_provider.dart';
import 'package:todo_app/database/tasks_dao.dart';
import 'package:todo_app/ui/styles/my_theme_data.dart';
import 'package:todo_app/ui/widgets/task_item_widget.dart';

class tasksListTab extends StatefulWidget {

  @override
  State<tasksListTab> createState() => _tasksListTabState();
}

class _tasksListTabState extends State<tasksListTab> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<MyAuthProvider>(context);
    return Container(

      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (newdate) {
              selectedDate = newdate;
              setState(() {

              });
            },
            headerProps: const EasyHeaderProps(
              showHeader: false,
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              landScapeMode: true,
              inactiveDayNumStyle: TextStyle(color: Colors.grey),
              todayStyle: DayStyle(
                dayNumStyle: TextStyle(color: Colors.grey)
              ),
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff5D9CEC),
                      Color(0xff5D9CEC),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: TasksDao.listenForTasks(authProvider.databaseUser!.id!,selectedDate),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.hasError){
                    return Center(
                      child: Column(
                        children: [
                          Text('Something went wrong'),
                           ElevatedButton(onPressed: () {
                             setState(() {

                             });
                           }, child: Text('Try again'))
                        ],
                      ),
                    );
                  }
                  var tasksList = snapshot.data;
                  return ListView.builder(itemBuilder: (context, index) => taskItemWidget(task: tasksList![index]) ,itemCount: tasksList?.length ?? 0 ,);
                  
                },
            ),
          )
        ],
      ),
    );
  }
}
