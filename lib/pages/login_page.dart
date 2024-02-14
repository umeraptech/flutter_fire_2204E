import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/widgets/custom_strings.dart';
import 'package:flutter/material.dart';

import '../screens/task_screen.dart';
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
  // final TextEditingController _userNameController = TextEditingController();
  late bool _obscured;

  final togglePassowrdFocusNode = FocusNode();
  bool _isProcessing = false;

  String? email;
  String? pass;

  //for diolog box
  final _dialogKey = GlobalKey<FormState>();
  String? displayName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscured = true;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AuthenticateHelpler().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BackGroundContainer(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 300, 20, 0),
          child: fillBody(),
        ),
      ),
    );
  }

  Widget fillBody() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 10.0,
            ),
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
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              obscureText: _obscured,
              maxLength: 8,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "User Password",
                  hintText: "Enter User Passord",
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                        _obscured
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  )),
              validator: validatePass,
              onSaved: (value) {
                setState(() {
                  pass = value;
                });
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            _isProcessing
                ? const SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: Center(child: CircularProgressIndicator()))
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      beveledButton(onTap: onLoginSubmit, title: 'Login'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      beveledButton(onTap: () {}, title: 'Register'),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (togglePassowrdFocusNode.hasPrimaryFocus) {
        return;
      }
      togglePassowrdFocusNode.canRequestFocus = false;
    });
  }

  void onLoginSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // ScaffoldMessenger.of(context)
      // .showSnackBar(const SnackBar(content: Text('Login in....')));
      setState(() {
        _isProcessing = true;
      });
      await Future.delayed(const Duration(seconds: 2), () {});
      _signInUser();
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _signInUser() async {
    AuthenticateHelpler()
        .signIn(email: email.toString(), password: pass.toString())
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Succesfull login')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value)));

        Future.delayed(const Duration(seconds: 2), () {});

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    String? name;
    //String? u_email;
    bool? emailVerified;
    //String? uid;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      name = user.displayName;
      //u_email = user.email;
      emailVerified = user.emailVerified;
      //uid = user.uid;
    }

    if (name == null) {
      // ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Enter user name")));
      await _updateNameDialog();

      String name = displayName.toString();
       await Future.delayed(const Duration(seconds: 2), () {});
      //ScaffoldMessenger.of(context)
      //      .showSnackBar( SnackBar(content: Text(name.toTitleCase())));
      await user?.updateDisplayName(name.toTitleCase());
    }else{
      await Future.delayed(const Duration(seconds: 2), () {});
      ScaffoldMessenger.of(context)
           .showSnackBar( SnackBar(content: Text("Welcome, ${name.toTitleCase()}")));
    }

    await Future.delayed(const Duration(seconds: 2), () {});
    if(emailVerified==false){
      await Future.delayed(const Duration(seconds: 2), () {});
      ScaffoldMessenger.of(context)
           .showSnackBar(const SnackBar(content: Text("Your email is not varified\nSending verification email")));
      await Future.delayed(const Duration(seconds: 2), () {});
      await user?.sendEmailVerification();
      await Future.delayed(const Duration(seconds: 2), () {});
      await AuthenticateHelpler().signOut();
      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }else{
      String displayName = user!.displayName.toString();
      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => TaskScreen(displayName:displayName)));
    }



  }

  Future<void> _updateNameDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade800,
            title: Text('Add User Name', style: Theme.of(context).textTheme.titleMedium),
            content: Form(
              key: _dialogKey,
              child: TextFormField(
                maxLength: 20,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Enter text',
                  prefixIcon: Icon(Icons.perm_identity),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'please enter name';
                  }
                  return null;
                },
                onSaved: (value) {
                  displayName = value;
                },
              ),
            ),
            actions: <Widget>[
              beveledButton(
                  onTap: () {
                    if (_dialogKey.currentState!.validate()) {
                      _dialogKey.currentState!.save();
                      Navigator.of(context).pop();
                    }
                  },
                  title: 'Register'),
              beveledButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) => super.widget));
                  },
                  title: 'Cencel'),    
            ],
          );
        });
  }
}
