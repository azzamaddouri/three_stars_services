// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';
import 'package:three_stars_services/ui/registration_screen.dart';
import 'package:three_stars_services/ui/search_screen.dart';
import 'package:three_stars_services/ui/user-details_screen.dart';
import 'package:three_stars_services/ui/user_form.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  bool isSwitched = false;
  bool isSwitched1 = true;
  List _users = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchusers() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("users-form-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _users.add({
          "First-name": qn.docs[i]["First-name"],
          "Last-name": qn.docs[i]["Last-name"],
          "Username": qn.docs[i]["Username"],
          "Id": qn.docs[i]["Id"],
          "Roles": qn.docs[i]["Roles"],
          "DocId": qn.docs[i].id,
        });
      }
    });

    return qn.docs;
  }

  archiveUser(verify) {
    if (verify == true) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }
  }

  activateUser(verify) {
    if (verify == false) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar3);
    }
  }

  @override
  void initState() {
    fetchusers();
    super.initState();
  }

  final snackBar = SnackBar(
    content: Text("Account successfully archived"),
  );
  final snackBar1 = SnackBar(
    content: Text("Account successfully unarchived"),
  );
  final snackBar2 = SnackBar(
    content: Text("Account successfully disactivated"),
  );
  final snackBar3 = SnackBar(
    content: Text("Account successfully activated"),
  );

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
                      context,
                      CupertinoPageRoute(
                          builder: (_) => BottomNavController()));
                }),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            child: Column(children: [
          SizedBox(
              height: 60.h,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "User control panel",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 187),
                          height: 7,
                          color: AppColors.deep_orange.withOpacity(0.2)),
                    ]),
              )),
          Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(children: [
                Expanded(
                    child: SizedBox(
                        height: 60.h,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                //<-- SEE HERE
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 2),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Search user here",
                              hintStyle: TextStyle(fontSize: 15.sp),
                              suffixIcon: Icon(
                                Icons.search,
                                color: AppColors.deep_orange,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.white24)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => SearchScreen())),
                          ),
                        ))),
                Padding(padding: EdgeInsets.only(left: 10)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => UserForm()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              //<-- SEE HERE
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 2),
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      height: 60.h,
                      width: 65.h,
                      child: const Center(
                        child: Icon(
                          Icons.person_add_outlined,
                          color: AppColors.deep_orange,
                        ),
                      ),
                    )),
              ])),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _users.length,
                itemBuilder: (_, index) {
                  return Card(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 16),
                    elevation: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${_users[index]["Id"]}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 136, 34),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                "Email address : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text("${_users[index]["DocId"]}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.assignment_ind_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                                size: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                "Username : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text("${_users[index]["Username"]}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_box_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                "User : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Row(
                                children: [
                                  Text("${_users[index]["First-name"]}"),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2),
                                  ),
                                  Text("${_users[index]["Last-name"]}"),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 10, right: 5),
                            child: Row(
                              children: [
                                Spacer(),
                                ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text("User details",
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.deep_orange,
                                                    )),
                                                content: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                  return Container(
                                                      height: 300,
                                                      child: Column(children: <
                                                          Widget>[
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .email_rounded,
                                                              color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          136,
                                                                          34)
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 3),
                                                            ),
                                                            Text(
                                                              "Email address",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        136,
                                                                        34),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                            "${_users[index]["DocId"]}"),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .assignment_ind_rounded,
                                                              color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          136,
                                                                          34)
                                                                  .withOpacity(
                                                                      0.5),
                                                              size: 24,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 3),
                                                            ),
                                                            Text(
                                                              "Username",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        136,
                                                                        34),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 83),
                                                          child: Text(
                                                              "${_users[index]["Username"]}"),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .account_box_rounded,
                                                              color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          136,
                                                                          34)
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 3),
                                                            ),
                                                            Text(
                                                              "User",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        136,
                                                                        34),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 24),
                                                              child: Text(
                                                                  "${_users[index]["First-name"]}"),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 2),
                                                            ),
                                                            Text(
                                                                "${_users[index]["Last-name"]}"),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .engineering_rounded,
                                                              color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          136,
                                                                          34)
                                                                  .withOpacity(
                                                                      0.5),
                                                              size: 24,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 3),
                                                            ),
                                                            Text(
                                                              "Roles",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        136,
                                                                        34),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        for (var i
                                                            in _users[index]
                                                                ["Roles"])
                                                          if (i["Admin"] ==
                                                              true)
                                                            Text("Admin"),
                                                        for (var i
                                                            in _users[index]
                                                                ["Roles"])
                                                          if (i["SVA Agent"] ==
                                                              true)
                                                            Text("SVA Agent"),
                                                        for (var i
                                                            in _users[index]
                                                                ["Roles"])
                                                          if (i["Call Center"] ==
                                                              true)
                                                            Text("Call Center"),
                                                        for (var i
                                                            in _users[index]
                                                                ["Roles"])
                                                          if (i["SAV Admin"] ==
                                                              true)
                                                            Text("SAV Admin"),
                                                        for (var i
                                                            in _users[index]
                                                                ["Roles"])
                                                          if (i["SAV Technician"] ==
                                                              true)
                                                            Text(
                                                                "SAV Technician"),
                                                        Row(children: [
                                                          Text(
                                                            "Archived",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      136,
                                                                      34),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Switch(
                                                              value: isSwitched,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  isSwitched =
                                                                      value;
                                                                });
                                                                archiveUser(
                                                                    isSwitched);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ),
                                                          Text(
                                                            "Activated",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      136,
                                                                      34),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Switch(
                                                            value: isSwitched1,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isSwitched1 =
                                                                    value;
                                                              });
                                                              activateUser(
                                                                  isSwitched1);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          )
                                                        ])
                                                      ]));
                                                }),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text("Close"))
                                                ],
                                              ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.description_outlined,
                                      color: AppColors.deep_orange,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, right: 1),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  UserDetails(_users[index])));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.draw_outlined,
                                      color: AppColors.deep_orange,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  );
                }),
          )
        ])));
  }
}
