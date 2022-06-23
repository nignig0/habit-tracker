import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outings/utils.dart';

class changeUsernameDialog extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController(text: user?.displayName);
    return AlertDialog(

      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(

          controller: usernameController,

          decoration: InputDecoration(
            label: Text("New name?"),
            contentPadding: EdgeInsets.zero,
          ),


        ),
      ),

      actions: [

        TextButton(onPressed: ()async{

          //change the name 
          try{
            await user?.updateDisplayName(usernameController.text);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'home');
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar);

          }catch(error){
            print(error);
            ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
          }
          

        }, 
        child: Text("Submit"), 
       
        ), 

        TextButton(onPressed: (){

          Navigator.pop(context);
          

        }, 
        child: Text("Cancel"), 
       
        ), 

      ]
      
    );
  }
}