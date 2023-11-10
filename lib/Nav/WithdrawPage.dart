import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retailerapp/Nav/navbar.dart';
import 'package:retailerapp/Nav/wallet.dart';
import 'package:retailerapp/main.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {

  TextEditingController walletBalance =TextEditingController();
  TextEditingController withdraw =TextEditingController();

  bool disable =false;

  @override
  void initState() {
    walletBalance.text=walletBal.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text('Withdraw Request',)
      ),

      body: SingleChildScrollView(
        child: Column(
            children: [
              const SizedBox(height: 5,),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: w,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    //     const Text('Wallet Balance',style: TextStyle(fontSize: 20),),
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    Container(
                      width:600,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Text(
                            'Balance Available:',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                          SizedBox(height: 5,),
                          Text(
                            walletBal.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: withdraw,
                      onChanged: (value){
                        if(double.tryParse(value)==null){
                          showSnackbar(context,"Invalid Amount");
                        }
                        else if((walletBal)<(double.tryParse(value)??0)){
                          showSnackbar(context,"Not Enough Balance");
                        }else{
                          double withdrawAmount=(double.tryParse(value)??0);
                        }
                        setState(() {

                        });
                      },
                      cursorHeight: 20,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'withdraw amount',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor: Colors.white,
                            elevation: 0,
                            // side: const BorderSide(
                            //   width: 1.0,
                            //   color: Colors.transparent,
                            // )
                          ),
                          onPressed: () async {
                            if(!disable) {
                              if (double.tryParse(withdraw.text) == null) {
                                showSnackbar(context,"Invalid Amount");
                              }
                              else if ((walletBal) < (double.tryParse(withdraw.text) ?? 0)) {
                                showSnackbar(context,"Not Enough Balance");
                              } else {
                                disable =true;
                                await FirebaseFirestore.instance.collection('stations').doc(currentUserId).update({
                                  'balance':FieldValue.increment(-1*(double.tryParse(withdraw.text)??0))
                                });
                                await FirebaseFirestore.instance.collection('withDrawRequests').add({
                                  'name':currentStationName,
                                  'userId':currentUserId,
                                  'withdrawAmount':double.tryParse(withdraw.text),
                                  'date':FieldValue.serverTimestamp(),
                                  'status':0,
                                }).then((value) => value.update({'id': value.id}));
                                showSnackbar(context,"withdraw request send successfully");
                                withdraw.text="";
                                walletBalance.text=((double.tryParse(walletBalance.text)??0)-(double.tryParse(withdraw.text)??0)).toStringAsFixed(2);
                                disable=false;

                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, _, __) => const Navigation(index: 3,),
                                    ));
                              }
                            }
                          },
                          child: const Text('Withdraw',style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]
        ),
      ),

    );
  }
  showSnackbar(BuildContext context, String content) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
