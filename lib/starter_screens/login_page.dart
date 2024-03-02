import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/BottomNaveBar/BottomNavBar.dart';
import 'package:todo/starter_screens/signup_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isCheck = true;
  bool _isLoading = false;
  final _googlesignin = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future _handleSignIn(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final GoogleSignInAccount? googleUser = await _googlesignin.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      if(userCredential != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/diary.avif"),
              fit: BoxFit.fitHeight
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Stack(
          children: [
            Center(
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              borderRadius: 0,
              blur: 20,
              alignment: Alignment.bottomCenter,
              border: 2,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.1),
                    Color(0xFFFFFFFF).withOpacity(0.05),
                  ],
                  stops: [
                    0.1,
                    1,
                  ]),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.5),
                  Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                  child: ListView(
                    children: [
                      Image.asset("assets/list.png",width: 70,height: 100,),
                      SizedBox(height: 20,),
                      Center(
                        child: Text("LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50
                          ),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          hintText: 'Enter Your Email',
                          hintStyle: TextStyle(
                              color: Colors.blue
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.blue
                          ),
                          suffixIcon: Icon(Icons.mail, color: Colors.blue,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.blue.shade100,width: 3)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.blue,width: 2)
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          obscureText: isCheck,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isCheck = !isCheck;
                                  });
                                },
                                icon: isCheck
                                    ? Icon(Icons.visibility_off, color: Colors.blue)
                                    : Icon(Icons.visibility, color: Colors.blue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.blue.shade100,width: 3)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.blue,width: 2)
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 80,right: 80),
                        child: ElevatedButton(
                            onPressed: () {
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                              backgroundColor: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              )
                            ),
                            child:Text('Login')
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do you have an account?", style: TextStyle(
                            color: Colors.blue.shade500,
                          ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Signup()
                                )
                                );
                              },
                              child: Text("Signup Now", style: TextStyle(
                                color: Colors.blue.shade700,
                              ),
                              )
                          )
                        ],
                      ),
                      Text('    ---------------OR---------------',
                      style: TextStyle(
                        color:Colors.blue.shade900,
                        fontSize: 30
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8,left: 45,right: 45),
                        child: InkWell(
                          onTap: () {
                            _handleSignIn(context);
                          },
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              ),
                              elevation: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width:25 ,height: 25,
                                      child: Image.asset('assets/google.png',fit: BoxFit.fitWidth,),
                                  ),
                                  Text("  Google", style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 50,right: 50),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 8,
                              padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),
                          label: Text('Apple'),
                          icon: Icon(Icons.apple),
                        ),
                      ),
                      Center(
                        child: Text('\n\nCopy Rights@',style: TextStyle(
                            color: Colors.blue.shade700
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: CircularProgressIndicator()
                ),
              )
          ]
        )
      ),
    );
  }
}