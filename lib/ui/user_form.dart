// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';
import 'package:three_stars_services/ui/users_screen.dart';
import 'package:three_stars_services/widgets/customButton.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isadmin = false;
  bool issavagent = false;
  bool iscallcenter = false;
  bool issavadmin = false;
  bool issavtechnician = false;
  bool validauth = false;
  var rng = Random();
  sendUserDataToDB() async {
    if (validauth == true) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;

      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("users-form-data");
      return _collectionRef.doc(_emailController.text).set({
        "First-name": _firstnameController.text,
        "Last-name": _lastnameController.text,
        "Username": _usernameController.text,
        "Id": rng.nextInt(100).toString(),
        "Roles": [
          {
            "Admin": isadmin,
            "SVA Agent": issavagent,
            "Call Center": iscallcenter,
            "SAV Admin": issavadmin,
            "SAV Technician": issavtechnician
          }
        ],
        "ImageURL": "",
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => UsersScreen()));
      }).catchError((error) => print("something is wrong. $error"));
    }
  }

  final snackBar = SnackBar(
    content: Text("User added successfully"),
  );

  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: "000000");
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        validauth = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.deep_orange,
              ),
              onPressed: () {
                Navigator.push(
                    context, CupertinoPageRoute(builder: (_) => UsersScreen()));
              }),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Submit form to add a user",
                  style:
                      TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Container(
                    margin: EdgeInsets.only(right: 75),
                    height: 7,
                    color: AppColors.deep_orange.withOpacity(0.2)),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                myTextField(
                    "First name", TextInputType.text, _firstnameController),
                SizedBox(
                  height: 10.h,
                ),
                myTextField(
                    "Last name", TextInputType.text, _lastnameController),
                SizedBox(
                  height: 10.h,
                ),

                myTextField(
                    "Username", TextInputType.text, _usernameController),
                SizedBox(
                  height: 10.h,
                ),
                myTextField(
                    "Email", TextInputType.emailAddress, _emailController),

                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.deep_orange,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      signUp();
                    },
                    icon: Icon(Icons.verified_outlined),
                    label: Text("Verify email address")),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: AppColors.deep_blue,
                                value: isadmin,
                                onChanged: (val) {
                                  setState(() {});
                                  isadmin = val!;
                                  print(val);
                                }),
                            Text("Admin"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: AppColors.deep_blue,
                                value: issavagent,
                                onChanged: (val) {
                                  setState(() {});
                                  issavagent = val!;
                                  print(val);
                                }),
                            Text("SVA Agent"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: AppColors.deep_blue,
                                value: iscallcenter,
                                onChanged: (val) {
                                  setState(() {});
                                  iscallcenter = val!;
                                  print(val);
                                }),
                            Text("Call Center"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: AppColors.deep_blue,
                                value: issavadmin,
                                onChanged: (val) {
                                  setState(() {});
                                  issavadmin = val!;
                                  print(val);
                                }),
                            Text("SAV Admin"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: AppColors.deep_blue,
                                value: issavtechnician,
                                onChanged: (val) {
                                  setState(() {});
                                  issavtechnician = val!;
                                  print(val);
                                }),
                            Text("SAV Technician"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // elevated button
                SizedBox(
                  height: 40.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.deep_orange,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      sendUserDataToDB();
                    },
                    child: Text("Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
