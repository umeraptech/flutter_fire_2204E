import 'package:flutter/material.dart';

Widget beveledButton(
  {
    required String title, 
  required GestureTapCallback onTap}
){
  return ElevatedButton(
    onPressed: onTap, 
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple.withOpacity(0.7),
      foregroundColor: Colors.cyan,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      )
    ),
    child: Text(title,style: const TextStyle(fontFamily: "Gothic"),)
    );
}