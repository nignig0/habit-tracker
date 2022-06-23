import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outings/models/tasks.dart';
import 'package:outings/utils.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
  DateTime date;
  
  CreateTaskScreen({required this.date});

}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final timeController = TextEditingController(text: "");
  final descriptionController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  DateTime? timeHolder;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Task for ${DateFormat.yMMMd().format(widget.date)}", 

            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 25,
            ), 
          
            ),

           const  SizedBox(height: 40),

            Form(
              key: _formKey, 
      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
      
                SizedBox(
                  width: 340,
                  child: TextFormField(
                    controller: nameController,

                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter a task name";
                      }
                      return null;
                    },
      
                  decoration: InputDecoration(

                    hintText: "Title of the task"
                  )
                    
                  ),
                ), 
      
                SizedBox(
                  width: 340,
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 5,

                  validator: (value) =>  null,
      
                  decoration: InputDecoration(
      
                    hintText: "A description please"
      
                  )
                    
                  ),
                ), 

                const SizedBox(height: 10),

                SizedBox(
                  width: 340,
                  child: TextFormField(
                    controller: timeController,
                    readOnly: true, 
                    

                    decoration: const  InputDecoration(
                      
                    label: Text("Time?")
                    ), 

                     onTap: ()async{

                       TimeOfDay? pickedTime = await showTimePicker(
                         initialTime: TimeOfDay.now(), 
                         context: context,
                         
                       );
                      
                       if(pickedTime != null){
                         DateTime dueDate = new DateTime(widget.date.year, widget.date.month, widget.date.day, pickedTime.hour, pickedTime.minute);

                         setState(() {
                        timeController.text = DateFormat.yMMMd().format(dueDate).toString();
                        timeHolder = dueDate;
                         }); 
                        
                       }
                    
                  }

                  ),
                ),

               
            const SizedBox(height: 20),

            SizedBox(
                  height: 65,
                  width: 300, 

                  child: OutlinedButton(
                    onPressed: () async{
                      //create the new task
                      ScaffoldMessenger.of(context).showSnackBar(loadingSnackBar);
                      final currentUser = await FirebaseAuth.instance.currentUser;
                      firestoreInstance.collection("Tasks").add(
                        {
                          "name": nameController.text, 
                          "description": descriptionController.text, 
                          "email": currentUser?.email,
                          "endTime":  timeHolder,
                          "done": false,
                        }
                      )
                      .then((value){
                        ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                        Navigator.pushReplacementNamed(context, 'calendar');
                      }).catchError((error){
                        ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
                        print(error);
                      });

                    },
                    child: const Text("Create Task!", 
                  style: TextStyle(
                    fontSize: 25, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  )),
                  style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFFE9574),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                )
                ), 
               )
      
              ],)
            ),
          ],
        ),
      )
      
    );
  }
}