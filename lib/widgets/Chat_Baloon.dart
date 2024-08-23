import 'package:flutter/material.dart';

class ChatBaloon extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  
  
  const ChatBaloon({super.key, required this.message,required this.isCurrentUser });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:isCurrentUser? Colors.teal : Colors.blue,borderRadius: BorderRadius.circular(10)),
      padding:const EdgeInsets.all(15),
      
      margin:const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(message,style:TextStyle(color:Colors.white)),
    );
  }
}