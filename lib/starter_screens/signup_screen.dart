import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:todo/starter_screens/login_page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isCheck1 = true;
  bool isCheck2 = true;

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
          body:Center(
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
                        child: Text("SIGNUP",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              hintText: 'Enter Your Name',
                              hintStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              suffixIcon: Icon(Icons.person, color: Colors.blue,),
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
                        padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              hintText: 'Enter Your Phone Number',
                              hintStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              suffixIcon: Icon(Icons.numbers, color: Colors.blue,),
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
                        padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.blue),
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
                        padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                        child: TextFormField(
                          obscureText: isCheck1,
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
                                    isCheck1 = !isCheck1;
                                  });
                                },
                                icon: isCheck1
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                        child: TextFormField(
                          obscureText: isCheck2,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              hintText: 'Enter Your Confirm Password',
                              hintStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: Colors.blue
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isCheck2 = !isCheck2;
                                  });
                                },
                                icon: isCheck2
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have account?", style: TextStyle(
                            color: Colors.blue.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Login()
                                )
                                );
                              },
                              child: Text("Login Now", style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              )
                          )
                        ],
                      ),
                      Center(
                        child: Text('\n\n\n\n\nCopy Rights@',style: TextStyle(
                            color: Colors.blue.shade700
                        ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}