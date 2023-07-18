import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: formkey,
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 200,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller:nameController ,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'name is null';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Name'
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is null';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Email'
                ),
              ),
              TextFormField(controller: passController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.length<6) {
                    return 'Password atleast 6 character';
                  }
                },
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                if (formkey.currentState!.validate()) {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passController.text.trim()).then((value){
                    FirebaseFirestore.instance.collection('login').doc(value.user!.uid).set({
                      'id':value.user!.uid,
                      'name':nameController.text,
                      'email':emailController.text,
                      'pass':passController.text,
                      'status':1,
                    });
                  });
                }

              }, child: const Text('Register'))
            ],
          ),
        ))
      ),
    );
  }
}