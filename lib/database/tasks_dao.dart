import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/model/task.dart';
import 'package:todo_app/database/user_dao.dart';

class TasksDao{
static CollectionReference<Task> getTasksCollection(String uid){
  return UserDao.getUsersCollection().doc(uid).collection(Task.collectionName).withConverter(
      fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
      toFirestore: (task, options) => task.toFireStore(),);
}
static Future<void> addTask(String uid,Task task){
 var tasksCollection = getTasksCollection(uid);
 var docRef = tasksCollection.doc();
 task.id = docRef.id;
 return docRef.set(task);
}
static Future<List<Task>> getAllTasks(String uid)async{ // one time read
  var tasksCollection = getTasksCollection(uid);
  var snapShot = await tasksCollection.get();
  return snapShot.docs.map((e) => e.data()).toList();
}

static Stream<List<Task>> listenForTasks(String uid, selectedDate) async*{ // real time changes
  var tasksCollection = getTasksCollection(uid);
  var stream = tasksCollection.where(
    'dateTime', isEqualTo: selectedDate,
  ).snapshots();
  yield* stream.
  map((querySnapshot) => querySnapshot.docs.map((e) => e.data()).toList());
}

static Future<void> deleteTask( String uid , String taskId ){
  var tasksCollection = getTasksCollection(uid);
  return tasksCollection.doc(taskId).delete();
}

}