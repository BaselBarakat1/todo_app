import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider/auth_provider.dart';
import 'package:todo_app/database/model/task.dart';
import 'package:todo_app/database/tasks_dao.dart';
import 'package:todo_app/ui/home/tasks_list_tab/tasks_list_tab.dart';
import 'package:todo_app/utils/dialog_utils.dart';

class taskItemWidget extends StatefulWidget {
Task task;

taskItemWidget({required this.task});

  @override
  State<taskItemWidget> createState() => _taskItemWidgetState();
}

class _taskItemWidgetState extends State<taskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.4,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(14),
              onPressed: (context) {
               deleteTask();
              },
              backgroundColor: Color(0xFFFE4A49),
              //foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
      ),
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).secondaryHeaderColor,
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(22)
              ),
            ),
            SizedBox(width: 25,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title ?? '',style: Theme.of(context).textTheme.titleLarge),
                   SizedBox(height: 4,),
                   Text(widget.task.description ?? '',style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:7.38 ,horizontal: 21.6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(Icons.done,color: Colors.white,size: 26,weight: 30),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteTask() async {
    var authProvider = Provider.of<MyAuthProvider>(context,listen: false);
    await TasksDao.deleteTask(authProvider.databaseUser!.id!, widget.task.id!);
    DialogUtils.showMessage(context, 'Task deleted successfully',postiveActionTitle: 'Ok');
  }
}
