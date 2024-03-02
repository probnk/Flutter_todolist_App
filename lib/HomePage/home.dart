import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/HomePage/Missing.dart';
import 'package:todo/HomePage/Today.dart';
import 'package:todo/HomePage/Upcoming.dart';
import 'package:todo/TodoList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int isSeleted = 1;
  final _Title = TextEditingController();
  final _Description = TextEditingController();
  String? _Time;
  List<TodoList> list = [];
  String Dateselected = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  var ref = FirebaseFirestore.instance.collection('Tasks');
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;


  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  void initState(){
    super.initState();
    fetchTasks(Dateselected);
  }

  void fetchTasks(String selectedDate) async{
    var tasks = await FirebaseFirestore.instance
        .collection('Tasks')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.displayName!)
        .where('Date', isEqualTo: Dateselected)
        .get();

    setState(() {
      list = List.from(tasks.docs.map((doc) => TodoList.fromSnapshot(doc)));
    });
  }

  Widget _buildBottomSheet(
      context,
      scrollController,
      bottomSheetOffset,) {
    return ListView(
      children: [
        SizedBox(height: 10,),
        Center(
          child: Container(
            width: 70,
            height: 6,
            decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
        SizedBox(height: 10,),
        Center(
          child: Text("Add Notes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: _Title,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                hintText: 'Enter Title',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'Title',
                labelStyle: TextStyle(
                    color: Colors.white
                ),
                suffixIcon: Icon(Icons.title_rounded, color: Colors.white,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade600,width: 3)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white,width: 2)
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
          child: TextFormField(
            controller: _Description,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                hintText: 'Enter Description',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'Description',
                labelStyle: TextStyle(
                    color: Colors.white
                ),
                suffixIcon: Icon(Icons.title_rounded, color: Colors.white,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade600,width: 3)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white,width: 2)
                )
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 80,right: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025)
                      ).then((value) {
                        setState(() {
                          Dateselected = '${value?.day}/${value?.month}/${value?.year}';
                        });
                      });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    backgroundColor: Colors.black,
                    elevation: 8,
                  ),
                  icon: Icon(Icons.date_range),
                  label: Text('Date')
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        showSecondSelector: true,
                        context: context,
                        value: _time,
                        onChange: onTimeChanged,
                        minuteInterval: TimePickerInterval.FIVE,
                        onChangeDateTime: (DateTime dateTime) {
                          _Time = '${dateTime.hour}:${dateTime.minute} ${_time.hour >= 12 ? 'PM' : 'AM'} ';
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    backgroundColor: Colors.black,
                    elevation: 8,
                  ),
                  icon: Icon(Icons.timer),
                  label: Text('Time')
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 80,right: 80),
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                try{
                  ref.doc(FirebaseAuth.instance.currentUser!.email)
                  .collection(FirebaseAuth.instance.currentUser!.displayName!)
                  .doc(_Title.text)
                      .set({
                    'Title':_Title.text,
                    'Description':_Description.text,
                    'Time':_Time,
                    'Date':Dateselected,
                    'isChecked':false
                  }).then((value) => Fluttertoast.showToast(
                      msg:'Task is Added',
                      backgroundColor: Colors.black
                  ));
                }catch(e){
                  Fluttertoast.showToast(
                      msg:'Error:$e',
                      backgroundColor: Colors.black
                  );
                };
              });
            },
            style: ElevatedButton.styleFrom(
                elevation: 8,
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                )
            ),
            label: Text('Submit'),
            icon: Icon(Icons.request_page_sharp),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Card(
        elevation: 10,
        color: Colors.blue.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: FloatingActionButton(
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
              elevation: 0,
              child: Icon(Icons.note_add_sharp,size: 27,),
              onPressed: () {
                showFlexibleBottomSheet(
                  bottomSheetColor: Colors.white38,
                  minHeight: 0,
                  initHeight: 0.5,
                  maxHeight: 1,
                  context: context,
                  builder: _buildBottomSheet,
                  anchors: [0, 0.5, 1],
                  isSafeArea: true,
                );
              }
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: isSeleted,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Hello ${FirebaseAuth.instance.currentUser!.displayName}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              )),
                          TextSpan(
                              text: '\nYou\'ve got',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              )),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: 60,
                          height: 60,
                          child: Image.network('${FirebaseAuth.instance.currentUser!.photoURL}')),
                    )
                  ],
                ),
                Text('${list.length} Tasks Today',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    )),
                ButtonsTabBar(
                  labelSpacing: 5,
                  splashColor: Colors.cyan,
                  decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
                  ),
                  physics: ClampingScrollPhysics(),
                  elevation: 5,
                  radius: 20,
                  unselectedBackgroundColor: Colors.white,
                  height: 55,
                  contentPadding: EdgeInsets.all(10),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  onTap: (index) {
                    setState(() {
                      isSeleted = index;
                    });
                  },
                  tabs: [
                    Tab(
                      icon: Icon(Icons.call_missed),
                      text: "Missing",
                    ),
                    Tab(
                      icon: Icon(Icons.task),
                      text: "Today",
                    ),
                    Tab(
                      icon: Icon(Icons.upcoming),
                      text: 'Upcoming',
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 217,
                  child: TabBarView(
                    children: <Widget>[
                      Missing(),
                      Today(),
                      Upcoming(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}