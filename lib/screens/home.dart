// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outings/screens/calendar.dart';
import 'package:outings/widgets/ColoredBlock.dart';
import 'package:outings/widgets/appBar.dart';
import 'package:outings/widgets/changeUsernameDialog.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  var timeNow;
  final user = FirebaseAuth.instance.currentUser;

  @override
    void initState(){
      super.initState();

      setState(() {
        timeNow = DateTime.now().hour;
      });

    }

  @override
  Widget build(BuildContext context) {

    

  
    
    return Scaffold(

      
     backgroundColor: Color(0xFFFEFFFE), 
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 30),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SizedBox(height: 70),
           //Search bar and notification icon
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: (user?.displayName) != "" ? Text("Hello ${user?.displayName}!", 
             style: TextStyle(
               fontWeight: FontWeight.bold, 
               color: Colors.black, 
               fontSize: 25
             ),) 
             : 
             Text("Hello User!", 
             style: TextStyle(
               fontWeight: FontWeight.bold, 
               color: Colors.black, 
               fontSize: 25
             ),) ,
           ),

          SizedBox(height: 15), 

          Container(
            height: 150, 
            width: 350, 
            decoration: BoxDecoration(
              color : (timeNow >= 7 && timeNow <19)? Color(0xFFFE9574) : Color(0xFF4c347b),
              borderRadius: BorderRadius.circular(30),
            ), 
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 75),
                    child: Text('Today is ...\n${DateFormat.yMMMd().format(DateTime.now()).toString()}', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 25, 
                      fontWeight: FontWeight.bold
                    )),
                  ), 

                 

                ],
              ),
            ),
          ), 

          SizedBox(height: 20), 

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Today's Tasks", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 20,
            )),
          ),

          SizedBox(height:15) ,

          Expanded(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 25,
              runSpacing: 25,
              
              
              children: [
          
                ColoredBlock( 
                  color: Colors.grey,
                  height: 100,
                  width: 150, 
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        (timeNow > 7 && timeNow < 15) ? "Get Ready for the Day!": "Hope you had a good day!", 
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold,
                        fontSize: 19
                      )
                     ),
                    ),
                  )
                ), 
          
                ColoredBlock( 
                  color: Colors.lightBlueAccent,
                  height: 250,
                  width: 150, 
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("Drink some water!", 
                      overflow: TextOverflow.fade,
                       style: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold,
                        fontSize: 19
                      )
                     ),
                    ),
                  )
                ),
          
                ColoredBlock( 
                  color: Colors.amber.shade300,
                  height: 250,
                  width: 150, 
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("*trying to figure out what should be here*", 
                      overflow: TextOverflow.fade,
                       style: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold,
                        
                      )
                     ),
                    ),
                  )
                ), 

                 ColoredBlock( 
                  color: Color(0xFF02112d),
                  height: 100,
                  width: 150, 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(

                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> CalendarScreen()));
                          },

                          child: Text("View tasks!", 
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Color(0xFFBBBDC4), 
                            fontSize: 20
                          ),
                                           ),
                        ),
                    
                   


                      ],
                    ),
                  )
                ), 
          
                
          
              ],
            ),
          )

        

         ]
       ),
     ), 

     floatingActionButton: FloatingActionButton(onPressed: (){
       showDialog(context: context, builder: (_)=> changeUsernameDialog());
     },
      backgroundColor: Colors.lightBlueAccent,
      child: Icon(Icons.settings_rounded, color: Colors.white)
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      bottomNavigationBar: KanbanButtonAppBar(pageIndex: 0),
      );
  }
}