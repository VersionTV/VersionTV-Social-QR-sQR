import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/chat_service.dart';
import 'package:flutter_application_1/widgets/Chat_Baloon.dart';
class ChatView extends StatefulWidget {
  final String receiverName;
  final String receiverID;

   ChatView({super.key,
  required this.receiverName,required this.receiverID});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messagecontroller=TextEditingController();

  final ChatService _chatService=ChatService();

  final AuthService _authService=AuthService();
  FocusNode myfocus = FocusNode();
  @override
  void initState() {
    super.initState();
    myfocus.addListener(() { 
      if(myfocus.hasFocus){
        Future.delayed(const Duration(milliseconds: 500),()=>scrollDown(),);
      }
    });
    Future.delayed(const Duration(milliseconds:500 ),()=>scrollDown());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    myfocus.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }
  final ScrollController _scrollController=ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,duration:const Duration(seconds: 1),curve: Curves.fastOutSlowIn, );
  }

  void sendMessage() async{
    if(_messagecontroller.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverID, _messagecontroller.text);
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text(widget.receiverName),backgroundColor: Color.fromARGB(255, 222, 222, 222),elevation: 0, ),
      body:Column(children: [
        Expanded(child: _buildMessageList(),),
        _buildUserInput(),
      ],)
    );

      
  }

  Widget _buildMessageList(){
    String senderID=_authService.currentUser!.uid;
    return StreamBuilder(stream:_chatService.getMessages(widget.receiverID, senderID),
    builder:(context,snapshot){
      if(snapshot.hasError){
        return const Text("Hata");
       

      }
       if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Yükleniyor...");
       }
       return ListView(
        controller: _scrollController,
        children:snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
       );
    });
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data=doc.data() as Map<String,dynamic>;

      bool isCurrentUser=data['senderID']==_authService.currentUser!.uid;
      var alighment = isCurrentUser ? Alignment.centerRight:Alignment.centerLeft;

    return Container(
      alignment: alighment,
      child:ChatBaloon(message:data["message"],isCurrentUser: isCurrentUser,) );
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom:30.0 ,left:20),
      child: Row(
        children:[Expanded(child: TextField(controller:_messagecontroller,decoration: InputDecoration(
                  hintText: 'Metin Giriniz',
                 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                        
                  ),
                   fillColor:Color.fromRGBO(0, 174, 255, 1) ,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
                focusNode: myfocus,
              ),),
        Container(
          decoration:BoxDecoration(color:Colors.blue,shape:BoxShape.circle),margin:const EdgeInsets.only(right:20,left:20),child:  IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward_rounded,size:30),color:Color.fromRGBO(255, 255, 255, 1),))]
      ),
    );
  }
}