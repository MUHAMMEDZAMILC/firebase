import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchingHome extends StatefulWidget {
  const SearchingHome({super.key});

  @override
  State<SearchingHome> createState() => _SearchingHomeState();
}

class _SearchingHomeState extends State<SearchingHome> {
  bool search = false;
  TextEditingController searCtrl = TextEditingController(),nameCtrl = TextEditingController(),nicknameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:search? TextFormField(controller:searCtrl ,decoration: const InputDecoration(hintText: 'search'),onChanged: (value) {
          setState(() {
      
          });
        },): const Text('Searching Home',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,letterSpacing: 0.5),),
        actions: [IconButton(onPressed: (){
          if (search) {
            search = false;
          }else{
            search = true;
          }
          setState(() {
            
          });
        }, icon: search?const Icon(Icons.close):const Icon(Icons.search))],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream:searCtrl.text==''?FirebaseFirestore.instance.collection('names').snapshots(): FirebaseFirestore.instance.collection('names').where("search",arrayContains: searCtrl.text.toLowerCase()).snapshots(),
          builder: (context,snap) {
            if (snap.hasData) {
               return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, index) {
              return ListTile(
                title: Text(snap.data!.docs[index]['name'].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,letterSpacing: 0.5)),
                subtitle: Text(snap.data!.docs[index]['nick'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,letterSpacing: 0.5)),
              );
            },);
            }else{
              return CircularProgressIndicator();
            }
           
          }
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
             showDialog(context: context, builder: (context) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Column(
                    children: [
                      TextFormField(
                        controller:nameCtrl ,
                        decoration: InputDecoration(
                          hintText: 'Name '
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: nicknameCtrl,
                         decoration: InputDecoration(
                          hintText: 'Nick Name '
                        ),
                      ),
                       const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        if (nameCtrl.text!=''&& nicknameCtrl.text!='') {
                          List searchdata =[];
                          String currentstr ='';
                          for (var i = 0; i < nameCtrl.text.length; i++) {
                            currentstr = "$currentstr${nameCtrl.text[i]}";
                            searchdata.add(currentstr);
                          }
                          FirebaseFirestore.instance.collection('names').doc().set({
                            "name":nameCtrl.text,
                            "nick":nicknameCtrl.text,
                            "search":searchdata
                          }).then((value) => Navigator.pop(context));
                        }
                      }, child: Text('Add',style: TextStyle(fontSize: 14,fontWeight:FontWeight.w500,letterSpacing: 0.5 ),))
                    ],
                  ),
                ),
              );
            },);
      },child: const Icon(Icons.add),),
    );
  }
}