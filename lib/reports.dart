import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';
 class Reports extends StatefulWidget {
   const Reports({Key? key}) : super(key: key);

   @override
   State<Reports> createState() => _ReportsState();
 }

 class _ReportsState extends State<Reports> {
   @override
   Widget build(BuildContext context) {
     return
       Scaffold(


         appBar: AppBar(
           title: Text('Reports'),
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
                     leading: Icon(Icons.call_received,color: Colors.green,),
                     title: Text(data[intex]['userName'].toString()),
                     trailing: Text(data[intex]['estimatePrice'].toString().substring(0,5)),
                   );
                 });

           },

         ),
       );

   }
 }
