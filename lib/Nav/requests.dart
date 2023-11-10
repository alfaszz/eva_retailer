import 'package:flutter/material.dart';
class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
    child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Pending',),
              Tab(text: 'Approved',),
              Tab(text: 'Rejected',),
            ],),
        title: Text('Requests'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: TabBarView(
        children:<Widget> [
          Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                height: 80, width: 450,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('username',style:
                      TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.check,color: Colors.green,size: 40,),
                        SizedBox(width: 20,),
                        Icon(Icons.close,color: Colors.red,size: 40,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

          Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  height: 80, width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('username approved',style:
                        TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  height: 80, width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('username rejected',style:
                        TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),




        ]
      ),
    ),
    );
  }
}
