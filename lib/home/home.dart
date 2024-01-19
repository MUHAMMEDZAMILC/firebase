// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key,this.name});
  String? name;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('login').where("status",isEqualTo: 1).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.teal,
              child: ListTile(
                textColor: Colors.white,
                title: Text(snapshot.data!.docs[index]['name']),
                subtitle: Text(snapshot.data!.docs[index]['email']),
                trailing: InkWell(
                  onTap: (){
                    FirebaseFirestore.instance.collection('login').doc(snapshot.data!.docs[index]['id']).update({
                      "status":2,
                    });
                  },
                  child: const Icon(Icons.delete,color: Colors.red,)),
              ),
            )
            );
        },);
          }
          return const CircularProgressIndicator();
         
        }
      )
    );
  }
}