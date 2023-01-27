// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/registration_screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;
  var pickedImage;

  setDataToTextField(data) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
                height: 70.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Edit your information",
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: AppColors.deep_orange,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 110),
                            height: 7,
                            color: AppColors.deep_orange.withOpacity(0.2)),
                      ]),
                )),
            Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 35),
                  child: const CircleAvatar(
                    radius: 71,
                    backgroundColor: AppColors.deep_orange,
                    child: CircleAvatar(
                      radius: 68,
                      backgroundImage: NetworkImage(
                          "https://assets.afcdn.com/story/20180728/1294326_w1080h687cx567cy383cxt0cyt0cxb1080cyb687.jpg"),
                    ),
                  ),
                ),
                Positioned(
                    top: 85,
                    left: 120,
                    child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.orangeAccent,
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Text(
                                      "Choose option",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.deep_orange),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            splashColor: Colors.orangeAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            splashColor: Colors.orangeAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            splashColor: Colors.orangeAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                ),
                                                Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              });
                        }))
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController =
                  TextEditingController(text: data["First-name"]),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController =
                  TextEditingController(text: data['Last-name']),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _ageController =
                  TextEditingController(text: data['Username']),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
                width: 1.sw,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () => updateData(),
                  child: const Text("Update"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    elevation: 3,
                  ),
                ))
          ],
        ));
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "First-name": _nameController!.text,
      "Last-name": _phoneController!.text,
      "Username": _ageController!.text,
    }).then((value) {
      final snackBar1 = const SnackBar(
        content: Text("Updated Successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      print("Updated Successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: AppColors.deep_orange,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return setDataToTextField(data);
          },
        ),
      )),
    );
  }
}
