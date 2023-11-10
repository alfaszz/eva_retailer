import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retailerapp/Nav/navbar.dart';
import 'package:retailerapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login> {

@override
  void initState() {

  emailController.text = 'stationx@gmail.com';
  passwordController.text= '123456';

    getData();
    super.initState();
  }
getData() async {
  print("jjjjjjjjjjjjjjj");
  QuerySnapshot data =await FirebaseFirestore.instance.collection('stations').get().onError((error, stackTrace) async {
    print("errrrrrr");
    return await Future.delayed(Duration(seconds: 1));
  });
  print("hereeeeee");
  print(data.docs.length);
for(DocumentSnapshot doc in data.docs){
  print(doc.data());
}
}
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  getStation()  {
    print(emailController.text);
    print(passwordController);
     FirebaseFirestore.instance.collection('stations').where('email',isEqualTo: emailController.text).snapshots().listen((event)  async {
      List datas=event.docs;
      if(datas.isNotEmpty){
        if(emailController.text.trim()==datas[0]['email']&&passwordController.text==datas[0]['password']){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navigation(index: 0)));
          loggedin = true;
          currentStationEail = datas[0]['email'];
          currentStationName  = datas[0]['name'];
          currentStationPlace = datas[0]['place'];
          currentUserId = datas[0]['id'];
          walletBal = datas[0]['balance'];

          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString('currentStationEmail', currentStationEail);
          prefs.setString('currentStationName', currentStationName);
          prefs.setString('currentStationPlace', currentStationPlace);
          prefs.setString('currentUserId', currentUserId);
          prefs.setString('walletBal', walletBal.toString());



        }else{
          print('wrong password');
        }
      }else{
        print('No station found');
      }
    });


      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('eva', style: TextStyle(
                    fontSize: 35, fontWeight: FontWeight.w500,
                  color: Colors.blue[900]),),
                ],
              ),
              Text('STATION LOGIN', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500,
              ),),

              SizedBox(height: 20,),

              const Text('Please enter details to log in', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400,
              ),),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  // try{
                    getStation();
                    FirebaseFirestore.instance.collection('test').add({
                      'test':'test'
                    });
                  // }
                  // catch(e){
                  //   print(e);
                  // }

                },
                child: Container(
                  height: 50, width: 400,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Continue',style: TextStyle( color: Colors.white),)
                  ),
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}
