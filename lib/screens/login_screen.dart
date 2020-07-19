import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travial/auth/auth_status_enum.dart';
import 'package:travial/auth/main_auth.dart';
import 'package:travial/screens/home_screen.dart';
import 'package:travial/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailEdit = TextEditingController();
  final _passwordEdit = TextEditingController();

  final MainAuth auth = MainAuth();

  bool _emailValidate,_passValidate;
  String _emailError,_passError;

  @override
  void initState() {
    super.initState();

    _emailValidate = false;
    _passValidate = false;
    _emailError = '';
    _passError = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
//                    key: _emailKey,
                    controller: _emailEdit,
//                    autovalidate: true,
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      icon: Icon(Icons.alternate_email),
                      errorText: _emailError,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  TextFormField(
//                    key: _passKey,
                    obscureText: true,
                    controller: _passwordEdit,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      icon: Icon(Icons.remove_red_eye),
                      errorText: _passError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
//                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context) => RaisedButton(
                      onPressed: () async{
                        print('clicked on Login');

                        setState(() {
                          String regex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          if(_emailEdit.text.isEmpty) {
                            _emailError = 'Please fill this field.';
                            _emailValidate = false;
                          }
                          else{
                            if(!RegExp(regex).hasMatch(_emailEdit.text)) {
                              _emailError = 'Please enter a valid email.';
                              _emailValidate = false;
                            }
                            else {
                              _emailValidate = true;
                              _emailError = '';
                            }
                          }
                          if(_passwordEdit.text.isEmpty){
                            _passError =  'Please fill this field.';
                            _passValidate = false;
                          }
                          else{
                            if(_passwordEdit.text.length < 6){
                              _passError = 'Please enter a valid password.';
                              _passValidate = false;
                            }
                            else{
                              _passValidate = true;
                              _passError = '';
                            }
                          }
                        });

                        if(_emailValidate == true &&_passValidate == true){
                          FirebaseUser user = await auth.signInWithEmail(_emailEdit.text,_passwordEdit.text);
                          if(user == null){
                            print('No User');

                            Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('No user with given username and password. Please signup for new user.')),
                            );
                          }
                          else {
                            print('user with email ${user.email} is logged in');
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen(auth: auth,user: user,whichSignIn: WhichSignIn.WITH_EMAIL,)));
                          }
                        }
                      },
                      child: Text('LOGIN'),
                    ),
                  ),
                  GestureDetector(
                    child: Text('Forgot Password?'),
                    onTap: (){
                      print('clicked on Forgot Password?');
                    },
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(
                            color: Colors.black,),
                        children: <TextSpan>[
                          TextSpan(text: ' Sign up',
                              style: TextStyle(
                                  color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignUpScreen())),
                          ),
                        ],
                    ),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    child: Text('SignIn With Google',style: TextStyle(color: Colors.white),),
                    onPressed: () async{
                      FirebaseUser user = await auth.signInWithGoogle();

                      if(user == null){
                        print('No User');

                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Google SignIn Error.')),
                        );
                      }
                      else {
                        print('user with email ${user.email} is logged in');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen(auth: auth,user: user,whichSignIn: WhichSignIn.WITH_GOOGLE,)));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
