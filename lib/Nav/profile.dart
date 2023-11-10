import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retailerapp/main.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:time_range/time_range.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
bool ?availablity;
String? availableFrom ;
String? availableTo ;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Station Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100, width: 450,
                decoration:BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$currentStationName $currentStationPlace',
                    style: TextStyle( fontSize: 30, color: Colors.white,),),
                ),
              ),
            ),

            SizedBox(height: 30,),

            Text('Choose Status',style: TextStyle(color: Colors.blue[900],fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            SlidingSwitch(
              value: false,
              width: 250,
              onChanged: (bool value) {
                print(value);
                availablity = value;
              },
              height : 55,
              animationDuration : const Duration(milliseconds: 400),
              onTap:(){

              },
              onDoubleTap:(){},
              onSwipe:(){},
              textOff : "Unavalaible",
              textOn : "Available",
              iconOff: Icons.disabled_by_default_outlined,
              iconOn: Icons.check_box,
              contentSize: 17,
              colorOn : Colors.green,
              colorOff : Colors.red,
              background : const Color(0xffe4e5eb),
              buttonColor : const Color(0xfff7f5f7),
              inactiveColor : const Color(0xff636f7b),
            ),

            SizedBox(height: 30,),
            Text('Update Closing Time',style: TextStyle(color: Colors.blue[900],fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            TimeRange(

              fromTitle: Text('From', style: TextStyle(fontSize: 18, color: Colors.grey),),
              toTitle: Text('To', style: TextStyle(fontSize: 18, color: Colors.grey),),
              titlePadding: 20,
              textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
              activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              borderColor: Colors.black,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: Colors.indigo,
              firstTime: TimeOfDay(hour: 9, minute: 00),
              lastTime: TimeOfDay(hour: 23, minute: 00),
              timeStep: 60,
              timeBlock: 30,
              onRangeCompleted: (range) {
                print(range?.start.format(context));

                availableFrom = range?.start.format(context);
               availableTo = range?.end.format(context);
                

                setState(() => print(range));},
            ),


            


        ]
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 28.0,right: 28),
        child: InkWell(
          onTap: (){
            FirebaseFirestore.instance.collection('stations').doc(currentUserId).update(
              {
                'available':availablity,
                'openFrom':availableFrom,
                'openTill':availableTo,
              }
            );
          },
          child: Container(
child: Center(
  child:   Text('Update',style: TextStyle(

    fontSize: 25,

    color: Colors.white,

    fontWeight: FontWeight.w600

  ),),
),
            height: 60,

            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20)
            ),
          ),
        ),
      ),

    );
  }
}
