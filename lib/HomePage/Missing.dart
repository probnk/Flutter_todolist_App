import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Skeleton.dart';
import '../TodoList.dart';

class Missing extends StatefulWidget {
  const Missing({super.key});

  @override
  State<Missing> createState() => _MissingState();
}

class _MissingState extends State<Missing> {
  List<TodoList> list = [];
  int? Choosen;
  String Dateselected = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  bool? isLoading;

  @override
  void initState(){
    super.initState();
    fetchTasks(Dateselected);
  }

  void fetchTasks(String Date) async{
    setState(() {
      isLoading = true;
    });
    try{
      var tasks = await FirebaseFirestore.instance
          .collection('Tasks')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(FirebaseAuth.instance.currentUser!.displayName!)
          .where('Date', isLessThan: Dateselected)
          .get();

      setState(() {
        list = List.from(tasks.docs.map((doc) => TodoList.fromSnapshot(doc)));
        isLoading = false;
      });
    }catch(e){
      print('Fail');
    }
  }

  timeline() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                  LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Missing Tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    TodoList t = list[index];
                    bool isTrue = t.isCheck!;
                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient:
                          LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 230,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '${t.title}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              decoration: isTrue
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '\n${t.text}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration: isTrue
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            color: Colors.white,
                                          )),
                                      TextSpan(
                                          text: '\n${t.time}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration: isTrue
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            color: Colors.white,
                                          )),
                                      TextSpan(
                                          text: '                  ${t.date}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration: isTrue
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            color: Colors.white,
                                          ))
                                    ])),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading!
      ? skelton2()
      :SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
            //  DateTimeline(),
              SizedBox(height: 20),
              timeline()
            ],
          ),
        ),
      ),
    );
  }
}