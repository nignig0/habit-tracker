import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outings/models/tasks.dart';
import 'package:outings/screens/createTaskScreen.dart';
import 'package:outings/screens/updateTaskScreen.dart';
import 'package:outings/utils.dart';
import 'package:outings/widgets/ColoredBlock.dart';
import 'package:outings/widgets/appBar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  
  
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}



class _CalendarScreenState extends State<CalendarScreen> {


  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final firestoreInstance = FirebaseFirestore.instance;
  final user =  FirebaseAuth.instance.currentUser;
  
  List<Task> taskArray = [];
  

@override
initState(){
  
  super.initState();
 

  initializeGeneralTaskArray(taskArray);
  

}
  void initializeGeneralTaskArray(List<Task> taskArray) async{
    await firestoreInstance.collection("Tasks") //get tasks
    .where("email", isEqualTo: user?.email).get()
    .then((task){
      task.docs.forEach((element) { 
        print(element);
        setState(() {
          taskArray.add(Task.fromFirebaseDoc(element)); });
        });
        

      

    })
    .catchError((error){
      print(error);
    });
    
  }
   
  
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
     
      body: Column(
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("User", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                fontSize: 25,
                )), 

              ],),
          ), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),

            child: TableCalendar(focusedDay: _focusedDay,
             firstDay: DateTime.utc(2019, 08, 12),
              lastDay: DateTime.utc(3000, 01, 01), 
              
            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                color: Color(0xFF06102C), 
              fontSize: 20,
              ),
              formatButtonVisible: false, 

              leftChevronIcon: Icon(
                Icons.chevron_left, 
                size: 30, 
                color: Color(0xFF131C39),
              ),

              rightChevronIcon: Icon(
                Icons.chevron_right, 
                size: 30, 
                color: Color(0xFF131C39),
              ),

            ), 

           calendarStyle: const CalendarStyle(

            
             
             

             selectedDecoration: BoxDecoration(
               shape: BoxShape.circle,
               color: Colors.lightBlueAccent
                
             ), 

             todayDecoration: BoxDecoration(
               shape: BoxShape.circle, 
               color: Color(0xFFFE9574)
             )

           ), 

           selectedDayPredicate: (day){
             //check if the current day that's selected is the real selected day
             return isSameDay(_selectedDay, day);
           },

           onDaySelected: (selectedDay, focusedDay ){
             
             if(!isSameDay(selectedDay, _selectedDay)){
               //if the present Selected day and the previous selected day are different 
               //make them the same 
               
               setState(() {
                 _selectedDay = selectedDay;
                 _focusedDay = focusedDay;
                
                
               });
               
             }
           }, 

          onPageChanged: (focusedDay){
            setState(() {
              _focusedDay = focusedDay;
            });
            
          },

          eventLoader: (day){
            List <Task> taskForToday = [];

            getTaskForDay(taskForToday, day);
            
            

            taskForToday.forEach((element) async{
              if(element.endTime.isAfter(DateTime.now())){
              await AwesomeNotifications().createNotification(
              content: NotificationContent(id: 1 , channelKey: 'Its time', 
              title: 'Hey have you done ${element.name}?', 
              body: 'Don\'t forget to double tap the block when you\'ve done it', 
              ), 
              schedule: NotificationCalendar.fromDate(date: element.endTime)
            ); //create the notification

            AwesomeNotifications().actionStream.listen((event) {
              Navigator.push(context, 
              MaterialPageRoute(builder: (_)=> CalendarScreen()));
            }); //leads to this page when you tap it

             }});
            return taskForToday;

            
          },
           
           calendarBuilders: CalendarBuilders(
             headerTitleBuilder: (context, day) {
               String month  = DateFormat.MMMM().format(day);
              
               return Center(
                 child: Text(month, 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))
               );
             },

          markerBuilder: (context, day, events){
            
            
            int numTasks = taskArray.where((element) => (element.endTime.isAfter(day) && element.endTime.isBefore(day.add(Duration(days: 1))))).length;
           
            
            return (numTasks > 0 )? Container(
              height: 15, 
              width: 15,
              child: Center(
                child: Text(numTasks.toString(), 
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                )),
              ), 

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber[300],
                border: Border.all(color: Colors.black)
              ),
            ) : SizedBox();
            
          }
           ),
            )
          
          ), 

            SingleChildScrollView(
              child: Wrap(
                
                spacing: 25, 
                runSpacing: 25,
                direction: Axis.horizontal,
                children: [
                  for(var task in taskArray.where((element) => (element.endTime.isAfter(_focusedDay) && element.endTime.isBefore(_focusedDay.add(Duration(days: 1))))))
                   
                  
                    GestureDetector(
            
                      onHorizontalDragUpdate:(details) async{
                        if(details.delta.dx < 0){ //right swipe
                          
                          try{
                        await firestoreInstance.collection("Tasks").doc(task.id).delete();
                        }catch(error){
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
                        }
            
                        }
                        
            
                      },
            
                      onDoubleTap: () async{
            
                          try{
                        await firestoreInstance.collection("Tasks").doc(task.id).update(
                          {
                            "done": !task.done
                          }
                         
                        );
                         setState((){
                           bool isDone = !task.done;
                           task.done = isDone;
                          });
                        }catch(error){
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
                        }
                        
                      },
            
                      onLongPress: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (_)=> UpdateTaskScreen(task, task.endTime)));
                      },
                      
                      child: ColoredBlock(color: (!task.done) ? ColorList[Random().nextInt(ColorList.length)] : Colors.grey.shade300, 
                      height: 80, width: 150, 
                      child: Center(child: Text(task.name))),
                    )
                ]
                  
              
                ),
            ),
            

        ],
      ),

     floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.push(context, 
       MaterialPageRoute(builder: (_)=> CreateTaskScreen(date: _focusedDay)));
     },
      child: const Icon(Icons.add), 
      backgroundColor:  Color(0xFFFE9574),
      ),
      
      bottomNavigationBar: KanbanButtonAppBar(pageIndex: 1),

    );
  }



  void getTaskForDay(List taskList, DateTime day) async{
    
    taskArray.forEach((task) { 
      if(task.endTime.isAfter(_focusedDay) && task.endTime.isBefore(_focusedDay.add(Duration(days: 1)))){

        taskList.add(task);

      }
    });
  }
}