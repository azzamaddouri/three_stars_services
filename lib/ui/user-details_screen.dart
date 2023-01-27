import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/users_screen.dart';

class UserDetails extends StatefulWidget {
  var _user;
  UserDetails(this._user, {Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController? _firstnameController;
  TextEditingController? _lastnameController;
  TextEditingController? _usernameController;

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(widget._user['DocId']).update({
      "First-name": _firstnameController!.text,
      "Last-name": _lastnameController!.text,
      "Username": _usernameController!.text,
      "Roles": [
        {
          "Admin": widget._user["Roles"][0]["Admin"],
          "SVA Agent": widget._user["Roles"][0]["SVA Agent"],
          "Call Center": widget._user["Roles"][0]["Call Center"],
          "SAV Admin": widget._user["Roles"][0]["SAV Admin"],
          "SAV Technician": widget._user["Roles"][0]["SAV Technician"]
        }
      ],
    }).then((value) {
      final snackBar1 = const SnackBar(
        content: Text("Updated Successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      print("Updated Successfully");

      Navigator.push(context, MaterialPageRoute(builder: (_) => UsersScreen()));
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
                child: SingleChildScrollView(
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
                                    "Edit user information",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      color: AppColors.deep_orange,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 110),
                                      height: 7,
                                      color: AppColors.deep_orange
                                          .withOpacity(0.2)),
                                ]),
                          )),

                      TextFormField(
                        controller: _firstnameController =
                            TextEditingController(
                                text: widget._user["First-name"]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _lastnameController = TextEditingController(
                            text: widget._user['Last-name']),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _usernameController = TextEditingController(
                            text: widget._user['Username']),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: widget._user['DocId'],
                          )),
                      SizedBox(
                        height: 20,
                      ),

                      Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.deep_blue,
                                      value: widget._user["Roles"][0]["Admin"],
                                      onChanged: (val) {
                                        setState(() {});
                                        widget._user["Roles"][0]["Admin"] =
                                            val!;
                                        print(val);
                                      }),
                                  Text("Admin"),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.deep_blue,
                                      value: widget._user["Roles"][0]
                                          ["SVA Agent"],
                                      onChanged: (val) {
                                        setState(() {});
                                        widget._user["Roles"][0]["SVA Agent"] =
                                            val!;
                                        print(val);
                                      }),
                                  Text("SVA Agent"),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.deep_blue,
                                      value: widget._user["Roles"][0]
                                          ["Call Center"],
                                      onChanged: (val) {
                                        setState(() {});
                                        widget._user["Roles"][0]
                                            ["Call Center"] = val!;
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
                                      value: widget._user["Roles"][0]
                                          ["SAV Admin"],
                                      onChanged: (val) {
                                        setState(() {});
                                        widget._user["Roles"][0]["SAV Admin"] =
                                            val!;
                                        print(val);
                                      }),
                                  Text("SAV Admin"),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.deep_blue,
                                      value: widget._user["Roles"][0]
                                          ["SAV Technician"],
                                      onChanged: (val) {
                                        setState(() {});
                                        widget._user["Roles"][0]
                                            ["SAV Technician"] = val!;
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
                        height: 20,
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
                  ),
                ))));
  }
}
