import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_login/modal/user.dart';
import 'package:flutter/foundation.dart';

class UserDao{
  final _databaseRef = FirebaseDatabase.instance.ref('comments');



  void saveUsers(Users user){
    _databaseRef.push().set(user.toJson());
  }

  Query getMessageQuery(){
    if(!kIsWeb){
        FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _databaseRef;
  }
}