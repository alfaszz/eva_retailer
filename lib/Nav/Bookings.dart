import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retailerapp/login.dart';
import 'package:retailerapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Boookings extends StatefulWidget {
  const Boookings({Key? key}) : super(key: key);

  @override
  State<Boookings> createState() => _BoookingsState();
}
var prefStationname;
var prefStationemail;
var prefStationid;
var prefStationbalance;
// var prefStation;

getprefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefStationname = prefs.getString("currentStationName");
}

// prefs() async {
//
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   prefs.setString('currentStationEmail', currentStationEail);
//   prefs.setString('currentStationName', currentStationName);
//   prefs.setString('currentStationPlace', currentStationPlace);
//   prefs.setString('currentUserId', currentUserId);
//   prefs.setString('walletBal', walletBal.toString());

//
// }



class _BoookingsState extends State<Boookings> {
@override
  void initState() {
  getprefs();
  // prefs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // void onLogoutSuccess() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   setState(() {
    //     isLoggedIn = true;
    //   });
    //   await prefs.setBool('isLoggedIn', false);
    //
    //
    // }
    return
      Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(

              ),
                child: Column(
                  children: [
                    Text(
                      'eva Retailer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[900],
                    ),
                    ),
                  ],
                )),
            Text(currentStationName.toString(),style: TextStyle(fontSize: 20,),),
            Text(currentUserId.toString(),style: TextStyle(fontSize: 20,),),
            Text(currentStationEail.toString(),style: TextStyle(fontSize: 20,),),
            Text(prefStationname.toString(),style: TextStyle(fontSize: 20,),),
            // Text(prefs.getString('currentStationName').toString()),
          // SharedPreferences prefs = await SharedPreferences.getInstance() ;



    SizedBox(height: 50,),
            InkWell(
              onTap: (){
                 // onLogoutSuccess();
                loggedin = false;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),
                ),
              )
            ),

          ],
        ),
              ),

      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('booking').where('stationId',isEqualTo: currentUserId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator(
              color: Colors.indigo,
            );
          }
          var data = snapshot.data?.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,intex){
            return ListTile(
              title: Text(data[intex]['userName']),
              subtitle:Text(data[intex]['id']) ,
            );
          });
        
      },
        
      ),
    );
  }
}
