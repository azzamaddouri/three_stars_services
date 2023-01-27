// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/add_work_force_screen.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/ui/search_screen.dart';
import 'package:three_stars_services/ui/settings-spare-parts.dart';
import 'package:three_stars_services/ui/settings_breakdown_screen.dart';

class SettingsWorkForces extends StatefulWidget {
  SettingsWorkForces({Key? key}) : super(key: key);

  @override
  State<SettingsWorkForces> createState() => _SettingsWorkForcesState();
}

class _SettingsWorkForcesState extends State<SettingsWorkForces> {
  bool floatbuttonvisible = true;
  List _workforces = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchWorkForces() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("work-forces-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _workforces.add({
          "WorkForce-name": qn.docs[i]["WorkForce-name"],
          "Price": qn.docs[i]["Price"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchWorkForces();
    super.initState();
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
                        "Work force management",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 124),
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
                              hintText: "Search work forces here",
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
                //Menu
                Padding(padding: EdgeInsets.only(left: 10)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AddWorkForce()));
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
                          Icons.add,
                          color: AppColors.deep_orange,
                        ),
                      ),
                    )),
              ])),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
              child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                if (!floatbuttonvisible) {
                  setState(() {
                    floatbuttonvisible = true;
                  });
                }
              } else {
                if (notification.direction == ScrollDirection.reverse) {
                  if (floatbuttonvisible) {
                    setState(() {
                      floatbuttonvisible = false;
                    });
                  }
                }
              }
              return true;
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _workforces.length,
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
                          "${_workforces[index]["WorkForce-name"]}",
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
                                Icons.money_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                "Price : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text("${_workforces[index]["Price"]} DT"),
                            ],
                          ),
                        ),
                        Text(""),
                      ],
                    ),
                  );
                }),
          ))
        ])),
        floatingActionButton: floatbuttonvisible
            ? SpeedDial(
                icon: Icons.miscellaneous_services_sharp,
                overlayOpacity: 0.4,
                backgroundColor: AppColors.deep_orange,
                spacing: 12,
                spaceBetweenChildren: 12,
                children: [
                  SpeedDialChild(
                      onTap: () {},
                      child: Icon(
                        Icons.calculate,
                        color: AppColors.deep_orange,
                      ),
                      label: 'Work force managment'),
                  SpeedDialChild(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SettingsSapreParts()));
                      },
                      child: Icon(Icons.wifi_protected_setup,
                          color: AppColors.deep_orange),
                      label: 'Spare part management'),
                  SpeedDialChild(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SettingsBreakdowns()));
                      },
                      child: Icon(Icons.construction_sharp,
                          color: AppColors.deep_orange),
                      label: 'Breakdown management'),
                  SpeedDialChild(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SettingsScreen()));
                      },
                      child: Icon(Icons.view_in_ar_sharp,
                          color: AppColors.deep_orange),
                      label: 'Product managment'),
                ],
              )
            : null);
  }
}
