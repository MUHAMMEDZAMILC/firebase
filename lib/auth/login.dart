import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: loginkey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Text('Login'),
              const SizedBox(height: 70,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is not valid';
                  }
                  return null;
                },
                decoration:const InputDecoration(
                  hintText: 'email'
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: passController,
                validator: (value) {
                  if (value!.isEmpty || value.length<6) {
                    return 'password not valid';
                  }
                  return null;
                },
                decoration :const InputDecoration(
                  hintText: 'password'
                ),
              ),
              const SizedBox(height: 40,),
                ElevatedButton(onPressed: (){
                  if (loginkey.currentState!.validate()) {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(), 
                      password: passController.text.trim()).then((value) => FirebaseFirestore.instance.collection('login').doc(value.user!.uid).get().then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(name: value.data()!['name'],)));
                      }));
                  }
                }, child: const Text('Login'))
            ],
          )),
        ),
      ),
    );
  }
}