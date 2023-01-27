// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class ClaimForm extends StatefulWidget {
  const ClaimForm({Key? key}) : super(key: key);

  @override
  _ClaimFormState createState() => _ClaimFormState();
}

class _ClaimFormState extends State<ClaimForm> {
  int _groupValue = -1;
  int _index = 0;
  TextEditingController _idController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneoneController = TextEditingController();
  TextEditingController _phonetwoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _availabilityController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _underwarrantyController = TextEditingController();
  TextEditingController _serialnumberController = TextEditingController();
  TextEditingController _retailerController = TextEditingController();
  TextEditingController _purchasedateController = TextEditingController();
  List<String> provinces = [
    "Ariana",
    "Bèja",
    "Ben Arous",
    "Bizerte",
    "Gabès",
    "Gafsa",
    "Jendouba",
    "Kairouan",
    "Kasserine",
    "Kébili",
    "La Manouba",
    "Le Kef",
    "Mahdia",
    "Medenine",
    "Monastir",
    "Nabeul",
    "Sfax",
    "Sidi Bouzid",
    "Siliana",
    "Sousse",
    "Tataouine",
    "Tozeur",
    "Tunis",
    "Zaghouan",
  ];
  List _brands = [];
  List _categories = [];
  List brands = [];
  List categories = [];
  List _models = [];
  List models = [];
  var rng = Random();
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
        _availabilityController.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
        availabilitydate = picked;
      });
    }
  }

  DateTime purchasedate = DateTime.now();
  Future<void> _selectDateFromPicker1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: purchasedate,
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
        _purchasedateController.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
        purchasedate = picked;
      });
    }
  }

  fetchBrands() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("brands-data").get();
    setState(() {
      _brands.clear();
      for (int i = 0; i < qn.docs.length; i++) {
        _brands.add(
          qn.docs[i]["Brand-name"],
        );
      }
    });
  }

  List<String> Brands() {
    brands.clear();
    _brands.forEach(
      (element) {
        brands.add(element);
      },
    );

    List<String> brandsList = brands.cast<String>();
    return brandsList;
  }

  fetchCategories() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _categories.clear();
    QuerySnapshot qn = await _firestoreInstance.collection("brands-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        for (var j = 0; j < qn.docs[i]["Categories"].length; j++) {
          _categories.add(qn.docs[i]["Categories"][j]["Category-name"]);
        }
      }
    });
  }

//2
  List<String> Categories() {
    categories.clear();
    _categories.forEach((element) {
      categories.add(element);
    });
    List<String> categoriesList = categories.cast<String>();
    return categoriesList;
  }

  Future fetchModels() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _models.clear();
    QuerySnapshot qn = await _firestoreInstance.collection("brands-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Brand-name"] == _brandController.text) {
          for (var j = 0; j < qn.docs[i]["Categories"].length; j++) {
            if (qn.docs[i]["Categories"][j]["Category-name"] ==
                _categoryController.text) {
              _models.add(qn.docs[i]["Categories"][j]["Models"]);
            }
          }
        }
      }
    });
    print(_models);
  }

  List<String> Models() {
    models.clear();

    for (var i = 0; i < _models.length; i++) {
      for (var j = 0; j < _models[i].length; j++) {
        models.add(_models[i][j]);
      }
    }

    List<String> modelsList = models.cast<String>();
    print(modelsList);
    return modelsList;
  }

  @override
  void initState() {
    super.initState();
    fetchBrands();
    Brands();
    fetchCategories();
    Categories();
  }

  sendClaimDataToDB() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("claims-form-data");
    return _collectionRef.doc().set({
      "Client": [
        _idController.text,
        _firstnameController.text,
        _lastnameController.text,
        _phoneoneController.text,
        _phonetwoController.text,
        _emailController.text,
        _provinceController.text,
        _addressController.text,
        _availabilityController.text,
      ],
      "Product": [
        _brandController.text,
        _categoryController.text,
        _modelController.text,
        _underwarrantyController.text,
        _serialnumberController.text,
        _retailerController.text,
        _purchasedateController.text,
      ],
      "CreatedAt": Timestamp.now(),
      "Status": "",
      "Reason": "",
      "HaveHappyCall": false,
      "Id": rng.nextInt(100000).toString(),
      "Diagnosis": [],
      "Quote": [
        {
          "Diagnostic-fee": 0,
          "Costs": 0,
          "Work-force-cost": 0,
          "Id": 0,
          "Work-force": [
            {"Work-force-name": "", "Price": 0}
          ],
          "Spare-part-price": "",
          "Spare-part-number": 0,
          "Status": "",
          "Total-amount": 0.0,
          "TVA": false,
        }
      ],
      "Interventions": [],
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Claim added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    }).catchError((error) => print("something is wrong. $error"));
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
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.deep_orange)),
          child: Stepper(
            currentStep: _index,
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () {
              final isLastStep = _index == 2 - 1;
              if (isLastStep) {
                sendClaimDataToDB();
              } else {
                setState(() {
                  _index += 1;
                });
              }
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = _index == 2 - 1;
              return Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    children: <Widget>[
                      if (_index != 0)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Cancel'),
                          ),
                        ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(isLastStep ? 'Save' : 'Next'),
                        ),
                      ),
                    ],
                  ));
            },
            steps: <Step>[
              Step(
                state: _index > 0 ? StepState.editing : StepState.indexed,
                isActive: _index >= 0,
                title: const Text('Fill in costumer information'),
                content: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          myTextField("ID card number", TextInputType.number,
                              _idController),
                          myTextField("First name", TextInputType.text,
                              _firstnameController),
                          myTextField("Last name", TextInputType.text,
                              _lastnameController),
                          myTextField("1st phone number", TextInputType.number,
                              _phoneoneController),
                          myTextField("2st phone number", TextInputType.number,
                              _phonetwoController),
                          myTextField("Email", TextInputType.emailAddress,
                              _emailController),
                          TextField(
                            controller: _provinceController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "choose province",
                              prefixIcon: DropdownButton<String>(
                                items: provinces.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                    onTap: () {
                                      setState(() {
                                        _provinceController.text = value;
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ),
                          myTextField("Address", TextInputType.text,
                              _addressController),
                          TextField(
                            controller: _availabilityController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Availability",
                              suffixIcon: IconButton(
                                  onPressed: () =>
                                      _selectDateFromPicker(context),
                                  icon: Icon(Icons.calendar_month)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Step(
                isActive: _index >= 1,
                title: Text('Fill in product information'),
                content: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _brandController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "choose brand",
                              prefixIcon: DropdownButton<String>(
                                items: Brands().map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                    onTap: () {
                                      setState(() {
                                        _brandController.text = value;
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextField(
                            controller: _categoryController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "choose category",
                              prefixIcon: DropdownButton<String>(
                                items: Categories()
                                    .toSet()
                                    .toList()
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
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
                          SizedBox(
                            height: 15.h,
                          ),
                          TextField(
                            onTap: () {
                              fetchModels();
                            },
                            controller: _modelController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "choose model",
                              prefixIcon: DropdownButton<String>(
                                items: Models().map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                    onTap: () {
                                      setState(() {
                                        _modelController.text = value;
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Warranty', style: TextStyle(fontSize: 18)),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: RadioListTile(
                                            value: 0,
                                            groupValue: _groupValue,
                                            title: Text("Yes"),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _groupValue = 0;
                                                _underwarrantyController.text =
                                                    "Yes";
                                                print(_underwarrantyController);
                                              });
                                            },
                                            activeColor: AppColors.deep_blue,
                                            selected: false,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: RadioListTile(
                                            value: 1,
                                            groupValue: _groupValue,
                                            title: Text("No"),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _groupValue = 1;
                                                _underwarrantyController.text =
                                                    "No";
                                                print(_underwarrantyController);
                                              });
                                            },
                                            activeColor: AppColors.deep_blue,
                                            selected: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          myTextField("Serial number", TextInputType.number,
                              _serialnumberController),
                          myTextField("Retailer", TextInputType.text,
                              _retailerController),
                          TextField(
                            controller: _purchasedateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Purchase date",
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    _selectDateFromPicker1(context),
                                icon: Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
