import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Skeleton.dart';
import '../TodoList.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<TodoList> list = [];
  String _Date = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  bool? isLoading;

  @override
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
          .collection('Tasks')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(FirebaseAuth.instance.currentUser!.displayName!)
          .where('Date', isEqualTo: _Date)
          .get();

      setState(() {
        list = tasks.docs.map((doc) => TodoList.fromSnapshot(doc)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Failure: $e');
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
                    'Today Tasks',
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
                    return InkWell(
                      onLongPress: () {
                        FirebaseFirestore.instance.collection('Tasks')
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection(FirebaseAuth.instance.currentUser!.displayName!)
                        .doc(t.title.toString())
                        .delete().then((value) => Fluttertoast.showToast(
                            msg:'Task is Deleted',
                            backgroundColor: Colors.black
                        )
                        );
                      },
                      child: Card(
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if(isTrue)
                                      return;
                                    else{
                                      setState(() {
                                        isTrue = !isTrue;
                                        list[index].isCheck = isTrue;
                                        FirebaseFirestore.instance.collection('Tasks')
                                            .doc(FirebaseAuth.instance.currentUser!.email)
                                            .collection(FirebaseAuth.instance.currentUser!.displayName!)
                                            .doc(t.title)
                                            .delete().then((value) => Fluttertoast.showToast(
                                            msg:'Task is Completed',
                                            backgroundColor: Colors.black
                                        )
                                        );
                                        FirebaseFirestore.instance.collection('History')
                                            .doc(FirebaseAuth.instance.currentUser!.email)
                                            .collection(FirebaseAuth.instance.currentUser!.displayName!)
                                            .doc()
                                            .set({
                                              'Title':t.title,
                                              'Description':t.text,
                                              'Date':t.date,
                                              'Time':t.time
                                        }).then((value) => print('Added to History'));
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: isTrue
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                        BorderRadius.circular(14),
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                    child: Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(13)),
                                        child: isTrue
                                            ? Icon(Icons.done,
                                            color: Colors.blue.shade500)
                                            : Icon(Icons.verified_outlined,
                                            color: Colors.transparent)),
                                  ),
                                ),
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
      body: isLoading!
          ? skelton()
          : SingleChildScrollView(
           child: Column(
            children: [
            SizedBox(
              height: 50,
            ),
            timeline(),
          ],
        ),
      ),
    );
  }
}