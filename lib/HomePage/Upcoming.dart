import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/TodoList.dart';

import '../Skeleton.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  String Dateselected = '${DateTime.now().day+1}/${DateTime.now().month}/${DateTime.now().year}';
  List<TodoList> list = [];
  bool? isLoading;

  @override
  void initState(){
    super.initState();
    fetchTasks(Dateselected);
  }

  void fetchTasks(String selectedDate) async{
    setState(() {
      isLoading = true;
    });
    var tasks = await FirebaseFirestore.instance
        .collection('Tasks')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.displayName!)
        .where('Date', isEqualTo: Dateselected)
        .get();

    setState(() {
      list = List.from(tasks.docs.map((doc) => TodoList.fromSnapshot(doc)));
      isLoading = false;
    });
  }

  DateTimeline(){
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 24),
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
            gradient:
            LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
            borderRadius: BorderRadius.circular(30),
          ),
          child: DatePicker(
            DateTime.now(),
            inactiveDates: [
              DateTime.now()
            ],
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              setState(() {
                Dateselected = '${date.day}/${date.month}/${date.year}';
              });
              fetchTasks(Dateselected);
            },
          ),
        ),
      ),
    );
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tasks',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$Dateselected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
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
                          padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 230,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '${t.title}',
                                          style: TextStyle(
                                              decoration: isTrue
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '\n${t.text}',
                                          style: TextStyle(
                                            decoration: isTrue
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            color: Colors.white,
                                          )),
                                      TextSpan(
                                          text: '\n${t.time}',
                                          style: TextStyle(
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
        ? Column(
        children: [
          DateTimeline(),
          SizedBox(height: 20),
          skelton()
        ],
      )
      :SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            DateTimeline(),
            SizedBox(height: 20),
            timeline()
            ],
          ),
        ),
      ),
    );
  }
}