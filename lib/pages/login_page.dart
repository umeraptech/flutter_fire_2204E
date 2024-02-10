import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/frm_validation.dart';
import '../widgets/beveled_button.dart';
import '../widgets/body_back.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); 
  late bool _obscured;
  final togglePassowrdFocusNode = FocusNode();

  String? email;
  String? pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscured = true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Login Page',
      style: Theme.of(context).textTheme.titleMedium,),),
      body: BackGroundContainer(
        Padding(
          padding: const EdgeInsets.fromLTRB(20,300,20,0),
          child: fillBody(),
        ),
      ),
    );
  }

  Widget fillBody(){
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize:  MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox( height: 10.0,),
            TextFormField(
              maxLength: 30,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "User Email",
                hintText: "Enter User Email",
                prefixIcon: Icon(Icons.email_outlined),
                
              ),
              validator: validateEmail,
              onSaved: (value){
                setState(() {
                 email =value;
                });
              },
            ),
            const SizedBox(height: 10.0,),
            TextFormField(
              obscureText: _obscured,
              maxLength: 8,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                labelText: "User Password",
                hintText: "Enter User Passord",
                prefixIcon: const Icon(Icons.key),
                suffixIcon: Padding(
                  padding:  const EdgeInsets.fromLTRB(0,0,4,0),
                  child: GestureDetector(
                    onTap: _toggleObscured,
                    child: Icon(
                      _obscured
                        ?Icons.visibility_rounded
                        :Icons.visibility_off_rounded,
                        size: 24,
                    ),
                  ),
                )
              ),              
              validator: validatePass,
              onSaved: (value){
                setState(() {
                 pass =value;
                });
              },
            ),
           const SizedBox(height: 10.0,),
           beveledButton( onTap: onLoginSubmit,title: 'Login'),
           const SizedBox(height: 10.0,),
           beveledButton( onTap: (){},title: 'Register'),
          ],
        ),
      ),
    );
  }

  void _toggleObscured(){
    setState(() {
      _obscured = !_obscured;
      if (togglePassowrdFocusNode.hasPrimaryFocus) {
        return;

      }
      togglePassowrdFocusNode.canRequestFocus=false;
    });
  }
  void onLoginSubmit(){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // ScaffoldMessenger.of(context)
      // .showSnackBar(const SnackBar(content: Text('Login in....')));

      _signInUser();
      
    }
  }


  void _signInUser(){
    AuthenticateHelpler()
    .signIn(email: email.toString(), password: pass.toString())
    .then((value){
      if (value==null) {
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Succesfull login')));
      }else{
        ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text(value)));
      }
    });
  }
}