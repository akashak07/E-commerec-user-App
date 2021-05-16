import 'package:e_commerce/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:e_commerce/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController NameInputController;
  TextEditingController emailInputController;
  TextEditingController phoneInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  @override
  initState() {
    NameInputController = new TextEditingController();
    phoneInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String namevalidator(String value){
    if(value.length<3){
      return "Enter a valid name";
    }else{
      return null;
    }
  }
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String phonevalidator(String value) {
    if (value.length != 10) {
      return "Enter valid Mobile number";
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(

    body: Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: EdgeInsets.fromLTRB(15,10, 0, 0),
                    child:Text('Register in to get started',style: TextStyle(color: Colors.black45,fontSize: 25,),)
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
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: 28.0,
                            ),
                          ),
                          controller: NameInputController,
                          keyboardType:  TextInputType.name,
                          validator: namevalidator,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 28.0,
                            ),),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 28.0,
                            ),),
                          controller:  phoneInputController,
                          keyboardType: TextInputType.phone,
                          validator:  phonevalidator,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 28.0,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _isObscure1 ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                }),
                          ),
                          controller: pwdInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: pwdValidator,
                          obscureText: _isObscure1,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _isObscure2 ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 28.0,
                            ),),
                          controller: confirmPwdInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: pwdValidator,
                          obscureText: _isObscure2,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 30,0, 0),
                          child: SizedBox(
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              color: Colors.orangeAccent,
                              onPressed: () {
                                if (_registerFormKey.currentState.validate()) {
                                  if (pwdInputController.text ==
                                      confirmPwdInputController.text) {
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                        email: emailInputController.text,
                                        password: pwdInputController.text)
                                        .then((currentUser) => Firestore.instance
                                        .collection("users")
                                        .document(currentUser.user.uid)
                                        .setData({
                                      "uid": currentUser.user.uid,
                                      "name": NameInputController.text,
                                      "phone": phoneInputController.text,
                                      "email": emailInputController.text,
                                    })
                                        .then((result) => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home(
                                              )),
                                              (_) => false),
                                      NameInputController.clear(),
                                     phoneInputController.clear(),
                                      emailInputController.clear(),
                                      pwdInputController.clear(),
                                      confirmPwdInputController.clear()
                                    })
                                        .catchError((err) => print(err)))
                                        .catchError((err) => print(err));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text("The passwords do not match"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                              child: Center(child:Text('REGISTER',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                            ),
                          ),
                        ),
                       Container(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(45,0, 0, 0),
                                child: Center(child: Text("Already have an account?",
                                    style:TextStyle(color: Colors.black)
                                )
                                ),
                              ),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                                  },
                                  child: Text("Login",
                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                  )
                              )

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),

              ],
          ),
        ),
      ),
    ),
  );
  }
}
