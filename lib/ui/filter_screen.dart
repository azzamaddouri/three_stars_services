// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool visible = true;
  bool visible1 = false;
  bool visible2 = false;
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;
  bool isChecked9 = false;
  bool isChecked10 = false;
  bool isChecked11 = false;
  bool isChecked12 = false;
  bool isChecked13 = false;
  bool isChecked14 = false;
  bool isChecked15 = false;
  bool isChecked16 = false;
  bool isChecked17 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: AppColors.deep_orange,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Choose filter",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.deep_orange,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 240),
                        height: 7,
                        color: AppColors.deep_orange.withOpacity(0.2)),
                  ]),
            )),
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    visible = true;
                    visible1 = false;
                    visible2 = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
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
                      Icons.sticky_note_2_outlined,
                      color: AppColors.deep_orange,
                    ),
                  ),
                )),
            //2
            GestureDetector(
                onTap: () {
                  setState(() {
                    visible = false;
                    visible1 = true;
                    visible2 = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 103, right: 80),
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
                      Icons.verified_outlined,
                      color: AppColors.deep_orange,
                    ),
                  ),
                )),
            GestureDetector(
                onTap: () {
                  setState(() {
                    visible = false;
                    visible1 = false;
                    visible2 = true;
                  });
                  //Navigator.push(context,
                  //MaterialPageRoute(builder: (_) => FilterScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5),
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
                      Icons.speaker_notes_outlined,
                      color: AppColors.deep_orange,
                    ),
                  ),
                )),
          ],
        ),
        SizedBox(height: 15),
        //1
        Visibility(
          visible: visible,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(right: 275),
                    child: Text(
                      "Warranty",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.deep_orange,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 275, left: 13),
                      height: 7,
                      color: AppColors.deep_orange.withOpacity(0.2)),
                ]),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked1,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked1 = value!;
                        });
                      },
                    ),
                    Text(
                      "No",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                )
              ]),
        ),
        //2

        Visibility(
          visible: visible1,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(right: 300),
                    child: Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.deep_orange,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 300, left: 13),
                      height: 7,
                      color: AppColors.deep_orange.withOpacity(0.2)),
                ]),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked3,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked3 = value!;
                        });
                      },
                    ),
                    Text(
                      "Refused",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked4,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked4 = value!;
                        });
                      },
                    ),
                    Text(
                      "Ongoing",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked5,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked5 = value!;
                        });
                      },
                    ),
                    Text(
                      "Sealed off",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked6,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked6 = value!;
                        });
                      },
                    ),
                    Text(
                      "Complete",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked7,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked7 = value!;
                        });
                      },
                    ),
                    Text(
                      "Opened",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked8,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked8 = value!;
                        });
                      },
                    ),
                    Text(
                      "Waiting",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                )
              ]),
        ),
        //3

        Visibility(
          visible: visible2,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(right: 300, left: 12.5),
                    child: Text(
                      "Reason",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.deep_orange,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 300, left: 13),
                      height: 7,
                      color: AppColors.deep_orange.withOpacity(0.2)),
                ]),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked9,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked9 = value!;
                        });
                      },
                    ),
                    Text(
                      "Refusal of reparation",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked10,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked10 = value!;
                        });
                      },
                    ),
                    Text(
                      "Cancellation by phone",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked11,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked11 = value!;
                        });
                      },
                    ),
                    Text(
                      "Quote confirmation",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked12,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked12 = value!;
                        });
                      },
                    ),
                    Text(
                      "Customer availability",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked13,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked13 = value!;
                        });
                      },
                    ),
                    Text(
                      "Spare part out of stock",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked14,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked14 = value!;
                        });
                      },
                    ),
                    Text(
                      "Repair difficulty",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked15,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked15 = value!;
                        });
                      },
                    ),
                    Text(
                      "Exchange Confirmation",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked16,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked16 = value!;
                        });
                      },
                    ),
                    Text(
                      "With repair",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked17,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked17 = value!;
                        });
                      },
                    ),
                    Text(
                      "With exchange",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ]),
    ));
  }
}
