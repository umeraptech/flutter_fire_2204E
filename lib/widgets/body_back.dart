import 'package:flutter/material.dart';

BackGroundContainer(child){
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      image: DecorationImage(
        image: const AssetImage('assets/images/background.jpg'),
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.dstATop)
      ),
    ),
    child: child,
  );
}