// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/add_breakdown_screen.dart';
import 'package:three_stars_services/ui/add_breakdown_type_screen.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/claims.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/ui/settings-spare-parts.dart';
import 'package:three_stars_services/ui/settings-work-forces.dart';

class SettingsBreakdowns extends StatefulWidget {
  SettingsBreakdowns({Key? key}) : super(key: key);

  @override
  State<SettingsBreakdowns> createState() => _SettingsBreakdownsState();
}

class _SettingsBreakdownsState extends State<SettingsBreakdowns> {
  var _firestoreInstance = FirebaseFirestore.instance;

  List docIds = [];
  List _b = [];
  List models = [];
  String istrue = "";
  bool floatbuttonvisible = true;
  fetchBrands() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("breakdowns-data").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _b.add({
          "Category-Name": qn.docs[i]["Category-Name"],
          "Breakdown-types": qn.docs[i]["Breakdown-types"]
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchBrands();
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
                        "Breakdown management",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 120),
                          height: 7,
                          color: AppColors.deep_orange.withOpacity(0.2)),
                    ]),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.add_circle_rounded,
                        size: 20,
                      ),
                      label: Text("Breakdown type"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => AddBreakdownType()));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.add_circle_rounded,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => AddBreakdown()));
                        },
                        label: Text("  Breakdown   ")),
                  ),
                ],
              )),
          SizedBox(
            height: 15,
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
                  itemCount: _b.length,
                  itemBuilder: (_, index) {
                    return Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            ExpansionTile(
                              title: Text(
                                "${_b[index]["Category-Name"]}",
                              ),
                              children: [
                                for (var i in _b[index]["Breakdown-types"])
                                  if (_b[index]["Breakdown-types"].isNotEmpty)
                                    ExpansionTile(
                                      title: Text(
                                        "${i["Breakdown-type-name"]}",
                                      ),
                                      children: [
                                        for (var j in i["Breakdowns"])
                                          if (i["Breakdowns"].isNotEmpty)
                                            ListTile(
                                              title: Text(
                                                "${j}",
                                              ),
                                            )
                                      ],
                                    )
                              ],
                            )
                          ],
                        ));
                  }),
            ),
          )
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SettingsWorkForces()));
                      },
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
                      onTap: () {},
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
