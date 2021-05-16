import 'package:flutter/material.dart';
import 'package:e_commerce/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginkey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordcontroller;
  bool _isObscure = true;

  @override
  initState() {
    emailController = new TextEditingController();
    passwordcontroller = new TextEditingController();
    super.initState();
  }


  String emailvalidator(String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp=RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return "E-mail format is invalid";
    }else{
      return null;
    }
  }

  String passwordvalidator(String value){
    if (value.length<8){
      return "Invalid Password";
    }else{
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Align(
                 alignment: Alignment.topLeft,
                 child: Container(
                     padding: EdgeInsets.fromLTRB(15,10, 0, 0),
                     child:Text('Log in to started',style: TextStyle(color: Colors.black45,fontSize: 25,),)
                 ),
               ),
               Align(
                 alignment: Alignment.topLeft,
                 child: Container(
                     padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                     child:Text('Experince the all new app',style: TextStyle(color: Colors.black45,fontSize: 20,),)
                 ),
               ),
               Container(
                 padding: EdgeInsets.all(25),
                 child: SingleChildScrollView(
                   child: Form(
                     key: _loginkey,
                     child: Column(
                       children: <Widget>[
                         TextFormField(
                           decoration: InputDecoration(
                             labelText: 'E-mail',

                             prefixIcon: Icon(
                               Icons.email_outlined,
                               size: 28.0,
                             ),),
                           controller: emailController,
                           keyboardType:  TextInputType.emailAddress,
                           validator: emailvalidator,
                         ),
                         TextFormField(
                           decoration: InputDecoration(
                             labelText: 'Password',
                             suffixIcon: IconButton(
                                 icon: Icon(
                                     _isObscure ? Icons.visibility : Icons.visibility_off),
                                 onPressed: () {
                                   setState(() {
                                     _isObscure = !_isObscure;
                                   });
                                 }),
                             prefixIcon: Icon(
                               Icons.lock,
                               size: 28.0,
                             ),),
                           controller: passwordcontroller,
                           keyboardType:  TextInputType.emailAddress,
                           validator: passwordvalidator,
                           obscureText: _isObscure,
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
                           child: SizedBox(
                             height: 60,
                             child: RaisedButton(
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0)
                               ),
                               color: Colors.orangeAccent,
                               onPressed: () {
                                    if (_loginkey.currentState.validate()) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                    email:  emailController.text,
                                    password: passwordcontroller.text)
                                        .then((currentUser) => Firestore.instance
                                        .collection("users")
                                        .document(currentUser.user.uid)
                                        .get()
                                        .then((DocumentSnapshot result) =>
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => Home(
                                    ))))
                                        .catchError((err) => print(err)))
                                        .catchError((err) => print(err));
                                    }
                                    },
                               child: Center(child:Text('Log In',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
    );
  }
}
