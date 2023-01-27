// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, prefer_const_constructors, avoid_print, non_constant_identifier_names, must_be_immutable, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';

class InterventionDetails extends StatefulWidget {
  var _claim;

  InterventionDetails(this._claim, {Key? key}) : super(key: key);

  @override
  State<InterventionDetails> createState() => _InterventionDetailsState();
}

class _InterventionDetailsState extends State<InterventionDetails> {
  int _groupValue = -1;
  TextEditingController _availabilityController = TextEditingController();
  TextEditingController _underwarrantyController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _statusController1 = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _breakdowntypeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _breakdownController = TextEditingController();
  TextEditingController _sparepartController = TextEditingController();
  TextEditingController _nextinterventionController = TextEditingController();
  TextEditingController _productstateController = TextEditingController();
  TextEditingController _workforceController = TextEditingController();
  TextEditingController _quotestatusController = TextEditingController();
  TextEditingController _interventiondateController = TextEditingController();
  TextEditingController _interventiontypeController = TextEditingController();
  TextEditingController _technicianreviewController = TextEditingController();
  TextEditingController _techniciannameController = TextEditingController();

  List _breakdownsTypes = [];
  List breakdownsTypes = [];
  List _breakdowns = [];
  List breakdowns = [];
  List _claimreasons = [];
  List claimreasons = [];
  bool isSwitched = false;
  List<String> claimstatus = [
    "Refused",
    "Ongoing",
    "Sealed off",
    "Complete",
    "Opened",
    "Waiting",
  ];

  List<String> productstate = [
    "Slightly scratched",
    "Badly scratched",
    "Body piling",
    "Foot missing",
  ];
  List<String> quotestatus = [
    "Accepted",
    "Refused",
    "Communicated with the customer",
    "Ongoing",
    "Waiting"
  ];
  List<String> NextIntervention = [
    "Mobile",
    "Fix",
  ];
  bool visible = false;
  bool visible1 = false;
  bool visible2 = false;
  bool visible3 = false;
  bool visible4 = false;
  bool visible5 = true;

  DateTime availabilitydate = DateTime.now();
  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: availabilitydate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.deep_orange, // <-- SEE HERE
              onPrimary: Colors.white,
              surface: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.deep_orange, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _interventiondateController.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
        availabilitydate = picked;
      });
    }
  }

  fetchClaimReasons() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _claimreasons.clear();
    QuerySnapshot qn = await _firestoreInstance.collection("Status-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Status-name"] == _statusController1.text) {
          for (var j = 0; j < qn.docs[i]["Reasons"].length; j++) {
            _claimreasons.add(qn.docs[i]["Reasons"][j]);
          }
        }
      }
    });
  }

  List<String> ClaimReasons() {
    claimreasons.clear();
    _claimreasons.forEach((element) {
      claimreasons.add(element);
    });
    List<String> claimreasonsList = claimreasons.cast<String>();
    return claimreasonsList;
  }

  fetchBreakdownsTypes() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _breakdownsTypes.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("breakdowns-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Category-Name"] == widget._claim['Product'][1]) {
          for (var j = 0; j < qn.docs[i]["Breakdown-types"].length; j++) {
            _breakdownsTypes
                .add(qn.docs[i]["Breakdown-types"][j]["Breakdown-type-name"]);
          }
        }
      }
    });
  }

  List<String> BreakdownsTypes() {
    breakdownsTypes.clear();
    _breakdownsTypes.forEach((element) {
      breakdownsTypes.add(element);
    });
    List<String> breakdownsTypesList = breakdownsTypes.cast<String>();
    return breakdownsTypesList;
  }

  Future fetchBreakdowns() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _breakdowns.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("breakdowns-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Category-Name"] == widget._claim['Product'][1]) {
          for (var j = 0; j < qn.docs[i]["Breakdown-types"].length; j++) {
            if (qn.docs[i]["Breakdown-types"][j]["Breakdown-type-name"] ==
                _breakdowntypeController.text) {
              _breakdowns.add(qn.docs[i]["Breakdown-types"][j]["Breakdowns"]);
            }
          }
        }
      }
    });
  }

  List<String> Breakdowns() {
    breakdowns.clear();
    for (var i = 0; i < _breakdowns.length; i++) {
      for (var j = 0; j < _breakdowns[i].length; j++) {
        breakdowns.add(_breakdowns[i][j]);
      }
    }

    List<String> breakdownsList = breakdowns.cast<String>();

    return breakdownsList;
  }

  List _forecasttimes = [];
  Future fetchForecasttimes() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _forecasttimes.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("forecast-times-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Category-Name"] == widget._claim['Product'][1]) {
          _forecasttimes.add([qn.docs[i].id, qn.docs[i]["Forecast-time"]]);
        }
      }
      print(_forecasttimes);
    });
  }

  String forecasttime = "";
  String Forecasttime() {
    _forecasttimes.forEach((element) {
      for (var i = 0; i < element.length; i++) {
        if (element[0] == _breakdownController.text) {
          forecasttime = element[1];
        }
      }
    });
    print(forecasttime);
    return forecasttime;
  }

  List _spareparts = [];
  Future fetchSpareParts() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _spareparts.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("spare-parts-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Category-name"] == widget._claim['Product'][1] &&
            qn.docs[i]["Breakdown-type-name"] ==
                _breakdowntypeController.text) {
          _spareparts.add(qn.docs[i]["SparePart-name"]);
        }
      }
    });
  }

  List spareparts = [];
  List<String> SpareParts() {
    spareparts.clear();
    _spareparts.forEach((element) {
      spareparts.add(element);
    });
    List<String> sparepartsList = spareparts.cast<String>();

    return sparepartsList;
  }

  List _workforces = [];
  Future fetchWorkForces() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _workforces.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("work-forces-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _workforces.add(qn.docs[i]["WorkForce-name"]);
      }
    });
  }

  List workforces = [];
  List<String> WorkForces() {
    workforces.clear();
    _workforces.forEach((element) {
      workforces.add(element);
    });
    List<String> workforcesList = workforces.cast<String>();

    return workforcesList;
  }

  String diagnosiscost = "0";
  getDia() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld.isEmpty) {
          diagnosiscost = "0";
        } else {
          if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
            diagnosiscost = ld[i]["Diagnosis"][ld[i]["Diagnosis"].length - 1]
                ["Breakdown"][0]["Breakdown-type"]["Spare-part"][0]["Price"];
          }
        }
      }
    });
    print(diagnosiscost);
  }

  List _technicians = [];
  fetchTechnicians() async {
    _technicians.clear();
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Roles"][0]["SAV Technician"]) {
          _technicians.add(ld[i]["Username"]);
        }
      }
    });
    print(_technicians);
  }

  List technicians = [];
  List<String> Technicians() {
    technicians.clear();
    _technicians.forEach((element) {
      technicians.add(element);
    });
    List<String> techniciansList = technicians.cast<String>();

    return techniciansList;
  }

  @override
  void initState() {
    super.initState();
    fetchClaimReasons();
    ClaimReasons();
    fetchBreakdownsTypes();
    BreakdownsTypes();
    fetchBreakdowns();
    Breakdowns();
    fetchForecasttimes();
    fetchSpareParts();
    SpareParts();
    fetchWorkForces();
    WorkForces();
    getDia();
    fetchTechnicians();
    Technicians();
  }

  bool haveaccessories = false;
  bool havegaz = false;
  bool havecost = false;
  //This is not ordered
  var docId;

  List _claim1 = [];
  updateWarranty() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
          docId = ld[i].id;

          _claim1 = ld[i]["Product"];
          for (var i = 0; i < _claim1.length; i++) {
            if (_claim1[i] == "Yes" || _claim1[i] == "No") {
              _claim1[i] = _underwarrantyController.text;
            }
          }
          print(_claim1);
        }
      }
    });
    final doc = FirebaseFirestore.instance
        .collection("claims-form-data")
        .doc(docId.toString())
        .update({"Product": _claim1}).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Warranty updated successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  updateClaimStatus() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
          docId = ld[i].id;
        }
      }
    });
    final doc = FirebaseFirestore.instance
        .collection("claims-form-data")
        .doc(docId.toString())
        .update({
      "Status": _statusController.text,
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Status updated successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    });
    ;
  }

  updateClaimReason() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
          docId = ld[i].id;
        }
      }
    });
    final doc = FirebaseFirestore.instance
        .collection("claims-form-data")
        .doc(docId.toString())
        .update({
      "Reason": _reasonController.text,
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Reason updated successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    });
  }

  String sparepartprice = "";
  List list1 = [];
  addDiagnosis() async {
    list1.clear();
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qsn =
        await _firestoreInstance.collection("spare-parts-data").get();
    setState(() {
      for (int i = 0; i < qsn.docs.length; i++) {
        if (qsn.docs[i]["SparePart-name"] == _sparepartController.text) {
          sparepartprice = qsn.docs[i]["Price"];
        }
      }
    });
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
          docId = ld[i].id;
          list1 = qn.docs[i]["Diagnosis"];
        }
      }
      list1.add({
        "Accessories": haveaccessories,
        "CreatedAt": Timestamp.now(),
        "Breakdown-description": _descriptionController.text,
        "Estimated-duration ": 0,
        "Product-state": _productstateController.text,
        "External-charges": havecost,
        "Gaz": havegaz,
        "Breakdown": [
          {
            "Forecast-time": Forecasttime(),
            "Breakdown-name": _breakdownController.text,
            "Breakdown-type": {
              "Breakdown-type-name": _breakdowntypeController.text,
              "Spare-part": [
                {
                  "Spare-part-name": _sparepartController.text,
                  "Price": sparepartprice
                }
              ]
            }
          }
        ],
      });
    });
    print(list1);
    final doc = FirebaseFirestore.instance
        .collection("claims-form-data")
        .doc(docId.toString())
        .update({
      "Diagnosis": list1,
      "Quote": [
        {
          "Diagnostic-fee": 0,
          "Costs": 0,
          "Work-force-cost": 0,
          "Id": 0,
          "Work-force": [
            {"Work-force-name": "", "Price": 0}
          ],
          "Spare-part-price": sparepartprice,
          "Spare-part-number": 0,
          "Status": "",
          "Total-amount": double.parse(diagnosiscost) + 50,
          "TVA": false,
        }
      ],
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Diagnosis added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  double workforceprice = 0.0;
  double amount1 = 0.0;
  getWorForcePrice() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection("work-forces-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["WorkForce-name"] == _workforceController.text) {
          workforceprice = double.parse(qn.docs[i]["Price"]);
        } else {
          workforceprice = 0.0;
        }
      }
    });
  }

  double totalamount = 0.0;
  double getTotalAmount() {
    if (_workforceController.text.isEmpty) {
      if (!widget._claim['Quote'][0]['TVA']) {
        totalamount = widget._claim['Quote'][0]['Total-amount'];
        return totalamount;
      } else {
        totalamount = widget._claim['Quote'][0]['Total-amount'] +
            widget._claim['Quote'][0]['Total-amount'] * 0.19;
        return totalamount;
      }
    } else {
      if (!widget._claim['Quote'][0]['TVA']) {
        totalamount =
            widget._claim['Quote'][0]['Total-amount'] + workforceprice;
        return totalamount;
      } else {
        totalamount = widget._claim['Quote'][0]['Total-amount'] +
            workforceprice +
            (widget._claim['Quote'][0]['Total-amount'] + workforceprice) * 0.19;
        return totalamount;
      }
    }
  }

  updateQuote() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
          docId = ld[i].id;
        }
      }
    });
    final doc = FirebaseFirestore.instance
        .collection("claims-form-data")
        .doc(docId.toString())
        .update({
      "Quote": [
        {
          "Diagnostic-fee": diagnosiscost,
          "Costs": 0,
          "Work-force-cost": workforceprice,
          "Id": rng.nextInt(1000),
          "Work-force": [
            {
              "Work-force-name": _workforceController.text,
              "Price": workforceprice
            }
          ],
          "Spare-part-price": widget._claim['Quote'][0]['Spare-part-price'],
          "Spare-part-number": 1,
          "Status": _quotestatusController.text,
          "Total-amount": widget._claim['Quote'][0]['Total-amount'],
          "TVA": widget._claim['Quote'][0]['TVA'],
        }
      ],
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Quote updated successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  SendQuoteToCustomer() {
    final snackBar1 = SnackBar(
      content: Text("Quote send to customer successfully"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
  }

  List list2 = [];
  var rng = Random();
  updateIntervention() async {
    list2.clear();
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        if (ld[i]["Product"].contains(widget._claim['Product'][4])) {
          docId = ld[i].id;
          list2 = qn.docs[i]["Interventions"];
        }
      }
      list2.add({
        "Intervention-Date": _interventiondateController.text,
        "Technician-review": _technicianreviewController.text,
        "CreatedAt": Timestamp.now(),
        "id": rng.nextInt(100000),
        "Technician-name": _techniciannameController.text,
        "Intervention-type": _interventiontypeController.text,
      });
    });
    final doc = FirebaseFirestore.instance
        .collection("claims-form-data")
        .doc(docId.toString())
        .update({
      "Interventions": list2,
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Intervention added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    }).catchError((error) => print("something is wrong. $error"));
  }

//Starts from here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 4, top: 10),
                  child: Row(children: [
                    //Product
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visible3 = true;
                            visible4 = false;
                            visible1 = false;
                            visible2 = false;
                            visible = false;
                            visible5 = false;
                          });
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 60.h,
                          width: 60.h,
                          child: const Center(
                            child: Icon(
                              Icons.home_outlined,
                              color: AppColors.deep_orange,
                            ),
                          ),
                        )),
                    //2
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visible4 = true;
                            visible3 = false;
                            visible1 = false;
                            visible2 = false;
                            visible = false;
                            visible5 = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 4,
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 60.h,
                          width: 60.h,
                          child: const Center(
                            child: Icon(
                              Icons.manage_history_outlined,
                              color: AppColors.deep_orange,
                            ),
                          ),
                        )),
                    //Client
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visible5 = true;
                            visible = false;
                            visible1 = false;
                            visible2 = false;
                            visible3 = false;
                            visible4 = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 4,
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 60.h,
                          width: 60.h,
                          child: const Center(
                            child: Icon(
                              Icons.checklist_outlined,
                              color: AppColors.deep_orange,
                            ),
                          ),
                        )),

                    //Show diagnostis form
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visible = true;
                            visible1 = false;
                            visible2 = false;
                            visible3 = false;
                            visible4 = false;
                            visible5 = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 4,
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 60.h,
                          width: 60.h,
                          child: const Center(
                            child: Icon(
                              Icons.troubleshoot_outlined,
                              color: AppColors.deep_orange,
                            ),
                          ),
                        )),
                    //Show Devis form
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visible1 = true;
                            visible = false;
                            visible2 = false;
                            visible3 = false;
                            visible4 = false;
                            visible5 = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 4,
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 60.h,
                          width: 60.h,
                          child: const Center(
                            child: Icon(
                              Icons.description_outlined,
                              color: AppColors.deep_orange,
                            ),
                          ),
                        )),
                    //Show intervention
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visible2 = true;
                            visible = false;
                            visible1 = false;
                            visible3 = false;
                            visible4 = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 4,
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 60.h,
                          width: 60.h,
                          child: const Center(
                            child: Icon(
                              Icons.inventory_outlined,
                              color: AppColors.deep_orange,
                            ),
                          ),
                        )),
                  ])),
              SizedBox(
                height: 30,
              ),
              Visibility(
                  visible: visible3,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 65.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Claim details",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      color: AppColors.deep_orange,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 240),
                                      height: 7,
                                      color: AppColors.deep_orange
                                          .withOpacity(0.2)),
                                ]),
                          )),
                      Card(
                        margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        elevation: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget._claim['Id'],
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.today,
                                    color: Color.fromARGB(255, 255, 136, 34)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  "Claiming date : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 136, 34),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(
                                  widget._claim['CreatedAt'].toString(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Customer details",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.deep_orange,
                                                  )),
                                              content: Container(
                                                  height: 380,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .quick_contacts_mail_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
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
                                                      Text(widget
                                                          ._claim['Client'][5]),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .featured_play_list_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "ID card",
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
                                                                right: 110),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][0]),
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "Full name",
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 24),
                                                            child: Text(widget
                                                                    ._claim[
                                                                'Client'][1]),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 2),
                                                          ),
                                                          Text(widget._claim[
                                                              'Client'][2]),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .quick_contacts_dialer_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "First phone number",
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
                                                                right: 110),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][3]),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .quick_contacts_dialer_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "Second phone number",
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
                                                                right: 110),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][4]),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "Province",
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
                                                                right: 130),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][6]),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .person_pin_circle_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "Address",
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
                                                                right: 90),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][7]),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.today_rounded,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3),
                                                          ),
                                                          Text(
                                                            "Availability",
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
                                                                right: 90),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][8]),
                                                      ),
                                                    ],
                                                  )),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("Close"))
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.location_history_rounded,
                                    color: Color.fromARGB(255, 255, 136, 34)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  "Customer : ",
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
                                    Text(widget._claim['Client'][1]),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2),
                                    ),
                                    Text(widget._claim['Client'][2]),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Product details",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.deep_orange,
                                                  )),
                                              content: Container(
                                                  height: 380,
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.style_rounded,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Brand",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    136,
                                                                    34),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 160),
                                                      child: Text(widget
                                                              ._claim['Product']
                                                          [0]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .shopping_cart_rounded,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Category",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    136,
                                                                    34),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 150),
                                                      child: Text(widget
                                                              ._claim['Product']
                                                          [1]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .view_in_ar_rounded,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Model",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    136,
                                                                    34),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 100),
                                                      child: Text(widget
                                                              ._claim['Product']
                                                          [2]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .sticky_note_2_rounded,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Warranty",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    136,
                                                                    34),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 160),
                                                      child: Text(widget
                                                              ._claim['Product']
                                                          [3]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.pin,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Serial number",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    136,
                                                                    34),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 100),
                                                      child: Text(widget
                                                              ._claim['Product']
                                                          [4]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .store_mall_directory_rounded,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Retailer",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    136,
                                                                    34),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 160),
                                                      child: Text(widget
                                                              ._claim['Product']
                                                          [5]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.today_rounded,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  136,
                                                                  34)
                                                              .withOpacity(0.5),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3),
                                                        ),
                                                        Text(
                                                          "Purchase date",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
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
                                                                right: 100),
                                                        child: Text(
                                                            widget._claim[
                                                                'Product'][6])),
                                                  ])),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Close")),
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.view_in_ar_rounded,
                                    color: Color.fromARGB(255, 255, 136, 34)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  "Product : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 136, 34),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(widget._claim['Product'][2]),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Update warranty",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.deep_orange,
                                                  )),
                                              content: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: RadioListTile(
                                                          value: 0,
                                                          groupValue:
                                                              _groupValue,
                                                          title: Text("Yes"),
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              _groupValue = 0;
                                                              _underwarrantyController
                                                                  .text = "Yes";
                                                              print(
                                                                  _underwarrantyController);
                                                            });
                                                          },
                                                          activeColor: AppColors
                                                              .deep_blue,
                                                          selected: false,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: RadioListTile(
                                                          value: 1,
                                                          groupValue:
                                                              _groupValue,
                                                          title: Text("No"),
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              _groupValue = 1;
                                                              _underwarrantyController
                                                                  .text = "No";
                                                              print(
                                                                  _underwarrantyController);
                                                            });
                                                          },
                                                          activeColor: AppColors
                                                              .deep_blue,
                                                          selected: false,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      updateWarranty();
                                                    },
                                                    child: Text("update")),
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.sticky_note_2_rounded,
                                    color: Color.fromARGB(255, 255, 136, 34)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  "Warranty : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 136, 34),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(widget._claim["Product"][3]),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Update status",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.deep_orange,
                                                  )),
                                              content: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return TextField(
                                                  controller: _statusController,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        widget._claim['Status'],
                                                    prefixIcon:
                                                        DropdownButton<String>(
                                                      items: claimstatus
                                                          .map((String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                          onTap: () {
                                                            setState(() {
                                                              _statusController
                                                                  .text = value;
                                                            });
                                                          },
                                                        );
                                                      }).toList(),
                                                      onChanged: (_) {},
                                                    ),
                                                  ),
                                                );
                                              }),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      updateClaimStatus();
                                                    },
                                                    child: Text("update")),
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.verified_rounded,
                                    color: Color.fromARGB(255, 255, 136, 34)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  "Status : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 136, 34),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(widget._claim['Status']),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Update reason",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.deep_orange,
                                                  )),
                                              content: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Container(
                                                    height: 100,
                                                    child: Column(children: [
                                                      TextField(
                                                        controller:
                                                            _statusController1,
                                                        readOnly: true,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: widget
                                                              ._claim['Status'],
                                                          prefixIcon:
                                                              DropdownButton<
                                                                  String>(
                                                            items: claimstatus
                                                                .map((String
                                                                    value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _statusController1
                                                                            .text =
                                                                        value;
                                                                  });
                                                                },
                                                              );
                                                            }).toList(),
                                                            onChanged: (_) {},
                                                          ),
                                                        ),
                                                      ),
                                                      TextField(
                                                        onTap: () {
                                                          fetchClaimReasons();
                                                        },
                                                        controller:
                                                            _reasonController,
                                                        readOnly: true,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: widget
                                                              ._claim['Reason'],
                                                          prefixIcon:
                                                              DropdownButton<
                                                                  String>(
                                                            items:
                                                                ClaimReasons()
                                                                    .map((String
                                                                        value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _reasonController
                                                                            .text =
                                                                        value;
                                                                  });
                                                                },
                                                              );
                                                            }).toList(),
                                                            onChanged: (_) {},
                                                          ),
                                                        ),
                                                      ),
                                                    ]));
                                              }),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      updateClaimReason();
                                                    },
                                                    child: Text("update")),
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.speaker_notes_rounded,
                                    color: Color.fromARGB(255, 255, 136, 34)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  "Reason: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 136, 34),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(widget._claim["Reason"]),
                              ],
                            ),
                            Text(""),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )),

              //Diagnosis
              Visibility(
                  visible: visible,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: 50.h,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Add diagnosis ",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 205),
                                    height: 7,
                                    color:
                                        AppColors.deep_orange.withOpacity(0.2)),
                              ]),
                        ),
                        TextField(
                          controller: _breakdowntypeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "choose breakdown type",
                            prefixIcon: DropdownButton<String>(
                              items: BreakdownsTypes()
                                  .toSet()
                                  .toList()
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _breakdowntypeController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 2,
                          decoration: InputDecoration(labelText: "Description"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          onTap: () {
                            fetchBreakdowns();
                          },
                          controller: _breakdownController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "choose breakdown",
                            prefixIcon: DropdownButton<String>(
                              items: Breakdowns().map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _breakdownController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          onTap: () {
                            fetchSpareParts();
                            getDia();
                          },
                          controller: _sparepartController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Spare part",
                            prefixIcon: DropdownButton<String>(
                              items: SpareParts()
                                  .toSet()
                                  .toList()
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _sparepartController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _nextinterventionController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Next intervention",
                            prefixIcon: DropdownButton<String>(
                              items: NextIntervention.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _nextinterventionController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(children: [
                          Text(
                            "Forecast time : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 34),
                            ),
                          ),
                          Text("${Forecasttime()} days"),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _productstateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Product state",
                            prefixIcon: DropdownButton<String>(
                              items: productstate.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _productstateController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    activeColor: AppColors.deep_blue,
                                    value: haveaccessories,
                                    onChanged: (val) {
                                      setState(() {
                                        haveaccessories = val!;
                                        print(val);
                                      });
                                    }),
                                Text("Accessories"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    activeColor: AppColors.deep_blue,
                                    value: havegaz,
                                    onChanged: (val) {
                                      setState(() {
                                        havegaz = val!;
                                        print(val);
                                      });
                                    }),
                                Text("Gas"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    activeColor: AppColors.deep_blue,
                                    value: havecost,
                                    onChanged: (val) {
                                      setState(() {
                                        havecost = val!;
                                        print(val);
                                      });
                                    }),
                                Text("Cost"),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.deep_orange,
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {
                              addDiagnosis();
                            },
                            child: Text("Save")),
                        SizedBox(
                          height: 5,
                        ),
                      ]))),
              //Devis
              Visibility(
                  visible: visible1,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(children: [
                        SizedBox(
                          height: 60.h,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit quote ",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 250),
                                    height: 7,
                                    color:
                                        AppColors.deep_orange.withOpacity(0.2)),
                              ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Spare part price : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 34),
                            ),
                          ),
                          Text("${diagnosiscost} DT"),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          onTap: () {
                            _workforceController.clear();
                            getWorForcePrice();
                          },
                          controller: _workforceController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "choose work force",
                            prefixIcon: DropdownButton<String>(
                              items: WorkForces()
                                  .toSet()
                                  .toList()
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _workforceController.text = value;
                                      getWorForcePrice();
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Diagnosis cost : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 34),
                            ),
                          ),
                          Text("50 DT"),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "TVA : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 34),
                            ),
                          ),
                          Switch(
                            value: widget._claim['Quote'][0]['TVA'],
                            onChanged: (value) {
                              setState(() {
                                widget._claim['Quote'][0]['TVA'] = value;
                              });
                            },
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Total : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 34),
                            ),
                          ),
                          Text(getTotalAmount().toString()),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _quotestatusController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "choose status",
                            prefixIcon: DropdownButton<String>(
                              items: quotestatus.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _quotestatusController.text = value;
                                      getWorForcePrice();
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      SendQuoteToCustomer();
                                    },
                                    child: const Text('Send'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      updateQuote();
                                    },
                                    child: Text('Save'),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 30,
                        ),
                      ]))),
              //Intervention
              Visibility(
                  visible: visible2,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(children: [
                        SizedBox(
                          height: 60.h,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Add intervention ",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: AppColors.deep_orange,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 185),
                                    height: 7,
                                    color:
                                        AppColors.deep_orange.withOpacity(0.2)),
                              ]),
                        ),
                        TextField(
                          controller: _interventiondateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Intervention date",
                            suffixIcon: IconButton(
                              onPressed: () => _selectDateFromPicker(context),
                              icon: Icon(Icons.today_outlined),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _techniciannameController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "choose technician",
                            prefixIcon: DropdownButton<String>(
                              items: Technicians()
                                  .toSet()
                                  .toList()
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _techniciannameController.text = value;
                                      getWorForcePrice();
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextField(
                          controller: _interventiontypeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Intervention type",
                            prefixIcon: DropdownButton<String>(
                              items: NextIntervention.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    setState(() {
                                      _interventiontypeController.text = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _technicianreviewController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          decoration:
                              InputDecoration(labelText: "Technician review"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.deep_orange,
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {
                              updateIntervention();
                            },
                            child: Text("Save")),
                        SizedBox(
                          height: 30,
                        ),
                      ]))),
              //Show Diagnosis
              Visibility(
                visible: visible4,
                child: SizedBox(
                    height: 50.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Diagnosis list",
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: AppColors.deep_orange,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 230),
                                height: 7,
                                color: AppColors.deep_orange.withOpacity(0.2)),
                          ]),
                    )),
              ),
              Visibility(
                  visible: visible4,
                  child: Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget._claim['Diagnosis'].length,
                          itemBuilder: (_, index) {
                            return Card(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 16),
                                elevation: 3,
                                child: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.miscellaneous_services_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Breakdown type : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Breakdown"][0]["Breakdown-type"]["Breakdown-type-name"]}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.description_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Breakdown description : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Breakdown-description"]}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.construction_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Breakdown : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Breakdown"][0]["Breakdown-name"]}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.wifi_protected_setup_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Spare part : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Breakdown"][0]["Breakdown-type"]["Spare-part"][0]["Spare-part-name"]}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.content_paste_search_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Product state : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Product-state"]}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.extension_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Accessories : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Accessories"]}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.gas_meter_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Gas : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["Gaz"]}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.money_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "External-charges : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Diagnosis'][index]["External-charges"]}",
                                        )
                                      ],
                                    ),
                                  ),
                                  Text("")
                                ]));
                          }))),
              //Show Intervention
              Visibility(
                visible: visible5,
                child: SizedBox(
                    height: 50.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Interventions list",
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: AppColors.deep_orange,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 205),
                                height: 7,
                                color: AppColors.deep_orange.withOpacity(0.2)),
                          ]),
                    )),
              ),
              Visibility(
                  visible: visible5,
                  child: Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget._claim['Interventions'].length,
                          itemBuilder: (_, index) {
                            return Card(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 16),
                                elevation: 3,
                                child: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.today,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Intervention date : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Interventions'][index]["CreatedAt"].toDate()}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.engineering_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Technician : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Interventions'][index]["Technician-name"]}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.mode_of_travel_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Intervention type : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Interventions'][index]["Intervention-type"]}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.preview_rounded,
                                          color:
                                              Color.fromARGB(255, 255, 136, 34)
                                                  .withOpacity(0.5),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "Technician review : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 136, 34),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Text(
                                          "${widget._claim['Interventions'][index]["Technician-review"]}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("")
                                ]));
                          })))
            ],
          ),
        ));
  }
}
