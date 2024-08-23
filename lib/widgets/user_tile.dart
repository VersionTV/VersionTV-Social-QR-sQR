import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class UserTile extends StatelessWidget{
  final String text;
  final void Function()? onTap;
  const UserTile({super.key,required this.text,required this.onTap});



  @override 
  Widget build(BuildContext context){
    return GestureDetector(
      onTap:onTap,child:Container(
        decoration: BoxDecoration(
          color:Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(11),
        ),
        margin:const EdgeInsets.symmetric(vertical:5,horizontal: 25),
        padding:EdgeInsets.all(30),
          child:Row(children: [const Icon(Icons.person),
          const SizedBox(width: 20),
          Text(text)],)
      )
    );
  }
}