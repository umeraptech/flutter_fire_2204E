import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/body_back.dart';

class TaskScreen extends StatefulWidget {
   TaskScreen({required this.displayName,super.key});
  String displayName;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}


class _TaskScreenState extends State<TaskScreen> {


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AuthenticateHelpler().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.displayName}',
        style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BackGroundContainer(
        Center(child: Container(
          color: Colors.amber.withOpacity(0.4),
          child: Text(
            "Task Sheet Coming Soon",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),)
      ),
    );
  }
}