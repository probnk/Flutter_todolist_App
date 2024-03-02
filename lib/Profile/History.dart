import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Skeleton.dart';
import '../BottomNaveBar/BottomNavBar.dart';
import '../TodoList.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<TodoList> list = [];
  bool? isLoading;

  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    try {
      var tasks = await FirebaseFirestore.instance
          .collection('History')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(FirebaseAuth.instance.currentUser!.displayName!)
          .get();

      setState(() {
        list = tasks.docs.map((doc) => TodoList.fromSnapshot(doc)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Failure: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                    Card(
                      elevation: 4,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                              },
                              icon: Icon(Icons.arrow_back,size: 30,)
                          ),
                          Text('       Task History',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                        ],
                      ),
                    ),
                Expanded(
                    child: isLoading!
                    ? skelton2()
                    :SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            TodoList t = list[index];
                            return Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient:
                                  LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${t.title}',style: TextStyle(
                                          color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text('${t.text}',style: TextStyle(
                                        fontSize: 18,
                                          color: Colors.white,
                                      ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${t.date}',style: TextStyle(
                                            fontSize: 18,
                                              color: Colors.white,
                                          ),
                                          ),
                                          Text('${t.time}',style: TextStyle(
                                            fontSize: 18,
                                              color: Colors.white,
                                          ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            );
                      }),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
