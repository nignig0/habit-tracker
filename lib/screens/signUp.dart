import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:outings/utils.dart';


class SignUpScreen extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {
    String password = "";
  String email = "";
  final _auth = FirebaseAuth.instance;

  GlobalKey<FormState> _formKey = GlobalKey();
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
        
        
                    const Text('Welcome to Kanban!', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 30,
                    )),
        
                    SizedBox(height: 40),
        
        
                    //email field
                    SizedBox(
                      width: 340,
                      child: TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25), 
                            borderSide: const BorderSide(color: Color(0xFFFE9574),)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),
                        ), 
        
                        validator: (value){
        
                          print(value);
                         
        
                          if(value!.isEmpty){
                            return "Enter an email";
                          }
        
                          if(!value.contains('@')){
                            //this is some flimsy validation
                            return "Please enter a valid email address!";
                          }
                          return null;
                        }, 
        
                        onChanged: (value){
                        
                            email = value;
                        }
        
                      ),
                    ),
        
                   const SizedBox(height: 20,),
        
                    //password field
                   SizedBox(
                     width: 340,
                     child: TextFormField(
                       autocorrect: false,
                       enableSuggestions: false,
                       obscureText: true,
        
                        onChanged: (value){
                         
                            password = value;
                          
                        },
        
                        validator: (value){
        
                        if(value!.length < 8){
                          return "Please make your password a wee bit longer";
                        }
                        return null;
        
                        },
        
                       decoration: InputDecoration(
                         hintText: "Enter your password",
                        
                          
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25)
                         )
                       ),
                     ),
                   ), 
        
                   const SizedBox(height: 20), 
                   SizedBox(
                     height: 65,
                     width: 300, 
                     child: OutlinedButton(onPressed: () async{
        
                       if(_formKey.currentState!.validate()){
                       
                      ScaffoldMessenger.of(context).showSnackBar(loadingSnackBar);
                       try{
                         
                         await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
        
                        ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                        Navigator.pushReplacementNamed(context, 'home');
                        
                       }catch(error){
                         ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
                        
                       }
                       }
                       
        
                     }, 
                     child: const Text("Sign Up!", 
                     style: TextStyle(
                           color: Colors.white,
                           fontSize: 25,
                           fontWeight: FontWeight.bold,
                         ),), 
                     style: OutlinedButton.styleFrom(
                       backgroundColor: Color(0xFFFE9574),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25)
                       ),
        
                       
        
                     ),
                     ),
                   ),

                   const SizedBox(height: 10),

              GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, 'logIn');
                },
                child: const Text("Have an account? Click me!", 
                style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.grey,
                
                          )),
              ),

                  ],)
        
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