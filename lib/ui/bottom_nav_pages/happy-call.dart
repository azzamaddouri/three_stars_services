// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:three_stars_services/const/AppColors.dart';

class HappyCall extends StatefulWidget {
  HappyCall({Key? key}) : super(key: key);

  @override
  State<HappyCall> createState() => _HappyCallState();
}

class _HappyCallState extends State<HappyCall> {
  double ratingproduct = 0;
  double ratingservices = 0;
  double ratingbehavior = 0;
  double ratingus = 0;
  int _groupValue = -1;

  TextEditingController _ratingpunctualityController = TextEditingController();
  TextEditingController _suggestionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Text('What do you think of our product ?'),
          RatingBar.builder(
              itemBuilder: ((context, _) => Icon(
                    Icons.star,
                    color: AppColors.deep_orange,
                  )),
              updateOnDrag: true,
              unratedColor: const Color(0xffb1c4dd),
              glowColor: AppColors.deep_orange,
              onRatingUpdate: (ratingproduct) => setState(() {
                    this.ratingproduct = ratingproduct;
                  })),
          Text('What do you think of our services ?'),
          RatingBar.builder(
              itemBuilder: ((context, _) => Icon(
                    Icons.star,
                    color: AppColors.deep_orange,
                  )),
              updateOnDrag: true,
              unratedColor: const Color(0xffb1c4dd),
              glowColor: AppColors.deep_orange,
              onRatingUpdate: (ratingservices) => setState(() {
                    this.ratingservices = ratingservices;
                  })),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Was the installer/technician on time ?',
                  style: TextStyle(fontSize: 18)),
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
                                _ratingpunctualityController.text = "Yes";
                                print(_ratingpunctualityController);
                              });
                            },
                            activeColor: Colors.red,
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
                                _ratingpunctualityController.text = "No";
                                print(_ratingpunctualityController);
                              });
                            },
                            activeColor: Colors.red,
                            selected: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text('What do you think of his behavior ?'),
              RatingBar.builder(
                  itemBuilder: ((context, _) => Icon(
                        Icons.star,
                        color: AppColors.deep_orange,
                      )),
                  updateOnDrag: true,
                  unratedColor: const Color(0xffb1c4dd),
                  glowColor: AppColors.deep_orange,
                  onRatingUpdate: (ratingbehavior) => setState(() {
                        this.ratingbehavior = ratingbehavior;
                      })),
              Text(
                  "Do you have any suggestions that we can add to our service ?"),
              TextFormField(
                controller: _suggestionsController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(hintText: "Suggestions"),
              ),
              Text('What rating can you give us out of 5 ?'),
              Text('$ratingus'),
              RatingBar.builder(
                  itemBuilder: ((context, _) => Icon(
                        Icons.star,
                        color: AppColors.deep_orange,
                      )),
                  updateOnDrag: true,
                  allowHalfRating: true,
                  unratedColor: const Color(0xffb1c4dd),
                  glowColor: AppColors.deep_orange,
                  onRatingUpdate: (ratingus) => setState(() {
                        this.ratingus = ratingus;
                      })),
            ],
          )
        ]));
  }
}
