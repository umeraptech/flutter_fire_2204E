import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({required this.displayName,super.key});
  String displayName;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List, ${widget.displayName}'),
      ),
    );
  }
}