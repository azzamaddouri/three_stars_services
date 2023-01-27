// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/ui/settings_breakdown_screen.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class AddBreakdownType extends StatefulWidget {
  AddBreakdownType({Key? key}) : super(key: key);

  @override
  State<AddBreakdownType> createState() => _AddBreakdownTypeState();
}

class _AddBreakdownTypeState extends State<AddBreakdownType> {
  TextEditingController _breakdowntypeController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  var docId;
  List _categories = [];
  List categories = [];
  List _breakdownstypes = [];
  fetchCategories() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _categories.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("breakdowns-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _categories.add(qn.docs[i]["Category-Name"]);
      }
    });
  }

  List<String> Categories() {
    categories.clear();
    _categories.forEach((element) {
      categories.add(element);
    });
    List<String> categoriesList = categories.cast<String>();
    return categoriesList;
  }

  addBreakDownTypeToDB() async {
    _breakdownstypes.clear();
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("breakdowns-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Category-Name"] == _categoryController.text) {
          docId = ld[i].id;
          _breakdownstypes = ld[i]["Breakdown-types"];
        }
      }
      _breakdownstypes.add({
        "Breakdown-type-name": _breakdowntypeController.text,
        "Breakdowns": []
      });
    });
    final doc = FirebaseFirestore.instance
        .collection("breakdowns-data")
        .doc(docId)
        .update({"Breakdown-types": _breakdownstypes}).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Breakdown Type added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SettingsBreakdowns()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    Categories();
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
                  Navigator.of(context).pop();
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
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Add breakdown type",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 160),
                          height: 7,
                          color: AppColors.deep_orange.withOpacity(0.2)),
                    ]),
              )),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: _categoryController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "choose category",
                prefixIcon: DropdownButton<String>(
                  items: Categories().toSet().toList().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                      onTap: () {
                        setState(() {
                          _categoryController.text = value;
                        });
                      },
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: myTextField(
                "Name", TextInputType.text, _breakdowntypeController),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                addBreakDownTypeToDB();
              },
              child: Text("Save")),
        ])));
  }
}
