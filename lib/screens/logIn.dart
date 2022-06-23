import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';


class LogInScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final _auth  = FirebaseAuth.instance;
    final GlobalKey<FormState> _formKey = GlobalKey();
    String email = "";
    String password = "";

    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey, 
                child: Column(
                  children: [
        
                  const Text('Log In!', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 30,
                    )),
        
                    


                    SizedBox(height: 40),

                    //username field
                    SizedBox(
                      width: 340,
                      child: TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Enter your username",
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
        
                        onChanged: (value){
                            
                              email = value;
                            
                        },
        
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter a username";
                          }
                          return null;
                        },
                      ),
                    ),
        
                    const SizedBox(height: 20), 
        
                    //password field 
                    SizedBox(
                      width: 340, 
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
        
                        onChanged: (value){
                            
                              password = value;
                           
                        },
        
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter your password please";
                          }
                          return null;
                        }
                      ),
                    ),
        
                    const SizedBox(height: 20),
        
                    SizedBox(
                      height: 65, 
                      width: 300,
                      child: OutlinedButton(onPressed: ()async{

                        if(_formKey.currentState!.validate()){
                        //submit the username and password to the server
                        ScaffoldMessenger.of(context).showSnackBar(loadingSnackBar);
                        try{
        
                       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
                       ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                       Navigator.pushReplacementNamed(context, 'home');
        
                        }catch(error){
                          print(error);
        
                          ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
                          
                          
                        }
                        }
        
        
                      },
                       child: const Text("Log In!", 
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 25,
                           fontWeight: FontWeight.bold,
                         ), ), 
                       style: OutlinedButton.styleFrom(
        
                        backgroundColor: Color(0xFFFE9574),
        
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(25), 
                         ), 
                         
                         
        
                         
                       ),),
                    ),

                    const SizedBox(height: 10),

              GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, 'signUp');
                },
                child: const Text("Don't have an account? Click me!", 
                style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.grey,
                
                          )),
              ),



                  
                  ],
                ),
              ),
                
            ],
          ),
        ),
      ), 

      bottomSheet:  Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Kanban is a product of the code clinic", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.grey,
              
            )),
          ],
        ),
      )
      
    );
  }
}