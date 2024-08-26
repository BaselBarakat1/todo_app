import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider/auth_provider.dart';
import 'package:todo_app/database/model/task.dart';
import 'package:todo_app/database/tasks_dao.dart';
import 'package:todo_app/ui/widgets/custom_text_form-field.dart';
import 'package:todo_app/utils/dialog_utils.dart';

class addTaskBottomSheet extends StatefulWidget {

  @override
  State<addTaskBottomSheet> createState() => _addTaskBottomSheetState();
}

class _addTaskBottomSheetState extends State<addTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(18),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             Text('Add new Task',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium),
              customTextFormField(labelText: 'Task Title',
                  controller: titleController,
                  validator:(input) {
                    if(input == null || input.isEmpty){
                      return 'Please enter Title';
                    }
                  }, ),
              SizedBox(height: 12),
              customTextFormField(labelText: 'Task Description',maxLines: 4,
                controller: descriptionController,
                validator: (input) {
                if(input == null || input.isEmpty){
                  return 'Please enter description';
                }
              },),
              InkWell(
                  onTap: () {
                    showTaskDatePicker();
                  },
                  child: Text(
                    finalSelectedDate==null? 'Select Time': '${finalSelectedDate?.day}/${finalSelectedDate?.month}/${finalSelectedDate?.year}'
                    ,style:Theme.of(context).textTheme.bodyMedium,)),
              Visibility(
                visible: showDateError,
                  child: Text('Please Select Time',style: TextStyle(fontSize: 11,color: Color(0xff8B0000)))),
              SizedBox(height: 8,),
              ElevatedButton(onPressed: () {
               addTask();
              }, child: Text('Add Task',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),),
            ],
          ),
        ),
      ),
    );
  }
DateTime? finalSelectedDate;
  bool showDateError = false;
  void showTaskDatePicker() async {
    var selectedDate = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    finalSelectedDate = selectedDate;
    setState(() {

    });
  }

  void addTask() {
    var authProvider = Provider.of<MyAuthProvider>(context,listen: false);
     if(!isValidForm()){
       return;
     }
     Task task = Task(
       title: titleController.text,
       description: descriptionController.text,
       dateTime: Timestamp.fromDate(finalSelectedDate!),
     );
     DialogUtils.showLoadingDialog(context, 'Creating Task...');
     TasksDao.addTask(authProvider.databaseUser!.id! ,task);
     DialogUtils.hideDialog(context);
     DialogUtils.showMessage(context, 'Task Created Successfully',icon: Icon(Icons.check_circle,color: Colors.green,),postiveActionTitle: 'ok',posAction: () {
       Navigator.pop(context);
     },);
    }

  bool isValidForm(){
    bool isValid = true;
    if(formKey.currentState?.validate() == false){
      isValid=false;
    }
    if(finalSelectedDate == null){
     showDateError=true;
     isValid = false;
     setState(() {

     });
    }
    return isValid;
  }
  }

