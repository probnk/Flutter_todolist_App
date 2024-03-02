import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: 250,
          child: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('${FirebaseAuth.instance.currentUser!.displayName}',style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  accountEmail:Text('${FirebaseAuth.instance.currentUser!.email}',style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: ClipOval(
                      child: Image.asset("assets/list.png",
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/diary.avif"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.home_filled,
                            size: 30,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10,),
                          Text("Home",style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.group,
                            size: 30,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10,),
                          Text("Friends",style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.contacts,
                            size: 30,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 10,),
                          Text("Contacts",style: TextStyle(
                              fontSize: 20,
                              color: Colors.yellow
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.favorite,
                            size: 30,
                            color: Colors.pinkAccent,
                          ),
                          SizedBox(width: 10,),
                          Text("Favourite",style: TextStyle(
                              fontSize: 20,
                              color: Colors.pinkAccent
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(color: Colors.grey),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.facebook,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 10,),
                          Text("FaceBook",style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.adb,
                            size: 30,
                            color: Colors.green.shade500,
                          ),
                          SizedBox(width: 10,),
                          Text("Android",style: TextStyle(
                              fontSize: 20,
                              color: Colors.green.shade500
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.youtube_searched_for,
                              size: 30,
                              color: Colors.red
                          ),
                          SizedBox(width: 10,),
                          Text("Youtube",style: TextStyle(
                              fontSize: 20,
                              color: Colors.red
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.help,
                            size: 30,
                            color: Colors.cyan,
                          ),
                          SizedBox(width: 10,),
                          Text("Help",style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan
                          ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
