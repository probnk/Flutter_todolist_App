import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/BottomNaveBar/BottomNavBar.dart';
import 'package:todo/Constants.dart';
import 'package:todo/Profile/History.dart';
import 'package:todo/starter_screens/login_page.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  final _auth = FirebaseAuth.instance;
  bool isTrue = false;
  colors c = colors();
  final _google_Signout = GoogleSignIn();
  List text = ['Set Reminder','Dark Mode'];
  List text1 = ['History','Logout'];
  List icons = [Icons.history,Icons.logout];
  List<bool> isSwitched = List.generate(2, (index) => false);

  Future _handleSignout(BuildContext context) async{
    try{
        _auth.signOut();
      await _google_Signout.signOut();
      if(_google_Signout.currentUser == null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }
      Fluttertoast.showToast(
          msg:'Logout',
          backgroundColor: Colors.black
      );
    }catch(e){
      Fluttertoast.showToast(
          msg:'Error:$e',
          backgroundColor: Colors.black
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isTrue ? c.black : c.white,
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    color: isTrue ? c.white : c.black,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                    },
                    icon:Icon(Icons.arrow_back_rounded,size: 30,)
                ),
                Text('User Profile',
                  style: TextStyle(
                      color: isTrue ? c.white : c.black,
                      fontSize: 30,fontWeight: FontWeight.bold),),
                IconButton(
                    color: isTrue ? c.white : c.black,
                    onPressed: () {},
                    icon:Icon(Icons.more_vert,size: 30,)
                )
              ],
            ),
            SizedBox(height: 40,),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage('${_auth.currentUser!.photoURL}'),
              ),
            ),
            SizedBox(height: 5,),
            Center(child: Text('${_auth.currentUser!.displayName}',
              style: TextStyle(
                  color: isTrue ? c.white : c.black,
                  fontSize: 16,fontWeight: FontWeight.bold),)
            ),
            Center(child: Text('${_auth.currentUser!.email}',
              style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)
            ),
            SizedBox(height: 40),
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient:
                            LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${text[index]}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Switch(
                                    inactiveTrackColor: Colors.grey,
                                    value: isSwitched[index],  // Corrected this line
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched[index] = value;  // Corrected this line
                                        print(isSwitched);
                                      });
                                      if(index == 1){
                                        setState(() {
                                          isTrue = !isTrue;
                                        });
                                      }
                                    },
                                    activeTrackColor: Colors.cyan,
                                    activeColor: Colors.blue.shade700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            }),
            SizedBox(height: 5,),
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      elevation: 8,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient:
                          LinearGradient(colors: [Colors.greenAccent, Colors.cyanAccent]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if(index == 0){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>History()));
                              } else{
                               _handleSignout(context);
                             }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 8,
                                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                )
                            ),
                            label:Text('${text1[index]}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            icon: Icon(icons[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Center(
              child: Text('\n\nCopy Rights@',style: TextStyle(
                  color: Colors.blue.shade700
              ),
              ),
            )
          ],
        ),
      )
    );
  }
}
