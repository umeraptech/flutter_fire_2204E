import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_login/services/user_dao.dart';
import 'package:flutter/material.dart';

import '../modal/user.dart';
import '../widgets/beveled_button.dart';
import '../widgets/body_back.dart';

class UserScreen extends StatefulWidget {
  UserScreen({required this.displayName, super.key});
  String displayName;
  UserDao users = UserDao();

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool editStatus = false;
  String? key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Comment List, ${widget.displayName}'),
      ),
      body: BackGroundContainer(
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: fillBody(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToBotom,
        child: const Icon(Icons.move_down),
      ),
    );
  }

  Widget fillBody() {
    return SafeArea(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter name",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: "Enter comment",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                beveledButton(onTap: () {
                  _saveData(_nameController.text, _commentController.text);
                 
                }, title: 'Save to database'),
                const SizedBox(
                  height: 5.0,
                ),

                ///list code coming soon
                _getMessageList(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _getMessageList() {
    return Expanded(
        child: FirebaseAnimatedList(
      controller: _scrollController,
      query: widget.users.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final users = Users.fromJson(json);
        return Card(
          color: Colors.black.withOpacity(0.3),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: ListTile(
              tileColor: Colors.grey.withOpacity(0.7),
              title: Text(users.name,
                  style: Theme.of(context).textTheme.bodyMedium),
              subtitle: Text(
                users.comment,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {
                    key = snapshot.key;
                    _nameController.text = users.name;
                    _commentController.text = users.comment;
                    editStatus = true;

                  }, icon: const Icon(Icons.edit)),
                  IconButton(onPressed: () {
                      key= snapshot.key;
                      _deleteData(key!);
                  }, icon: const Icon(Icons.delete))
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  void _scrollToBotom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void clearData(){
     _nameController.clear();
                  _commentController.clear();
  }

  void _saveData(String name, String comment){
    final user = Users(name,comment);
   
   switch(editStatus){
    case false:
     widget.users.saveUsers(user);
     clearData();
     break;
    case true:
      editStatus=false;
      widget.users.updateUser(key!, user);
      clearData();
     break;
   }

  }


  void _deleteData(String key){
    widget.users.deleteUser(key);
    clearData();
  }
}
