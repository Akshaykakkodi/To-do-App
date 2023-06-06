import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/add_task_screen.dart';
import 'package:todoapp/view_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userId;
  getUid(){
    FirebaseAuth auth=FirebaseAuth.instance;
     userId= auth.currentUser!.uid;
  }
  

  
  @override
  void initState() {
    getUid();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("To Do",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen(),));
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("tasks").doc(userId).collection("my tasks").snapshots(),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              final docs= snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var time= (docs[index]["time"] as Timestamp).toDate();
                  return
                    InkWell(
                      onTap:() {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTask (title: docs[index]["title"], description: docs[index]["description"]),));
                      },
                      child: Card(

                        color: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(docs[index]["title"],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text(DateFormat.yMd().add_jm().format(time))
                                ],
                              ),
                              IconButton(onPressed:  ()async {
                                print(docs[index]["time"].toString());
                                await FirebaseFirestore.instance
                                    .collection("tasks").doc(userId).collection("my tasks").doc(docs[index].id).delete();
                              }, icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      )
                    );

                },);
            }


          }
        ),
      ),
    );
  }
}