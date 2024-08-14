import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/model/user.dart';

class UserDao{
  static CollectionReference<User> getUsersCollection(){
    return FirebaseFirestore.instance.collection('users')
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),);
  }

  static Future<void> addUser(User user){
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String uid) async {
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(uid);
    var docSnapShot = await doc.get();
    return docSnapShot.data();

  }
}