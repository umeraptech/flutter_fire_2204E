import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_login/modal/user.dart';
import 'package:flutter/foundation.dart';

class UserDao{
  final _databaseRef = FirebaseDatabase.instance.ref('comments');



  void saveUsers(Users user){
    _databaseRef.push().set(user.toJson());
  }


  void updateUser(String key, Users users){
    _databaseRef.child(key).update(users.toMap());
  }

  void deleteUser(String key){
    _databaseRef.child(key).remove();
  }

  Query getMessageQuery(){
    if(!kIsWeb){
        FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _databaseRef;
  }
}