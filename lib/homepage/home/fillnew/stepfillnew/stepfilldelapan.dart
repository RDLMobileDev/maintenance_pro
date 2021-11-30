// ignore_for_file: sized_box_for_whitespace, unnecessary_const, avoid_unnecessary_containers

import 'package:e_cm/homepage/home/fillnew/additionpage/approvestepdelapan.dart';
import 'package:e_cm/homepage/home/services/apifillnewdelapan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillDelapan extends StatefulWidget {
  StepFillDelapan({Key? key}) : super(key: key);

  final StepFillDelapanState stepFillDelapanState = StepFillDelapanState();

  getMethodPostStep() {
    stepFillDelapanState.postStepDelapan();
  }

  @override
  StepFillDelapanState createState() => StepFillDelapanState();
}

class StepFillDelapanState extends State<StepFillDelapan> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? copyToGroup;
  String engineerTo = '', productTo = '', othersTo = '';

  setCopyTo() {
    print("Engineer");
    print(engineerTo);
    print("Product");
    print(productTo);
    print("Others");
    print(othersTo);
  }

  postStepDelapan() async {
    // print("saved 8");
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    String? ecmId = prefs.getString("idEcm").toString();

    String engineerToKey = prefs.getString("engineerTo") ?? "";
    String productToKey = prefs.getString("productTo") ?? "";
    String othersToKey = prefs.getString("othersTo") ?? "";

    try {
      var response = await fillNewDelapan(
          ecmId, engineerToKey, productToKey, othersToKey, tokenUser);

      if (response['response']['status'] == 200) {}
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan, silahkan dicoba lagi nanti',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
      );
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   child: const Text("E-Sign", style: TextStyle(fontFamily: 'Rubik', color: Color(0xFF404446), fontSize: 16, fontWeight: FontWeight.w400 ),),
            // ),
            // InkWell(
            //   onTap: (){
            //       Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => const ApproveStepDelapan())
            //       );
            //     },
            //   child: Container(
            //     margin: const EdgeInsets.only(top: 16),
            //     width: MediaQuery.of(context).size.width,
            //     height: 40,
            //     decoration: const BoxDecoration(
            //       color: Color(0XFF00AEDB),
            //       borderRadius: BorderRadius.all(Radius.circular(5))
            //     ),
            //     child: Row(
            //       // ignore: prefer_const_literals_to_create_immutables
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       // ignore: prefer_const_literals_to_create_immutables
            //       children: [
            //         const Icon(Icons.add_circle_outline, color: Colors.white,),
            //         const SizedBox(width: 10,),
            //         const Text("Add E-Sign", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 ),),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              child: const Text(
                "Copy to",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      final SharedPreferences prefs = await _prefs;
                      setState(() {
                        engineerTo = '1';
                        productTo = '0';
                        othersTo = '0';
                        copyToGroup = '1';
                        setCopyTo();
                      });
                      prefs.setString("engineerTo", engineerTo);
                      prefs.setString("productTo", productTo);
                      prefs.setString("othersTo", othersTo);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: copyToGroup,
                                  value: '1',
                                  onChanged: (value) async {
                                    final SharedPreferences prefs =
                                        await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        copyToGroup = value as String;
                                        engineerTo = '1';
                                        productTo = '0';
                                        othersTo = '0';
                                        setCopyTo();
                                      });
                                      prefs.setString("engineerTo", engineerTo);
                                      prefs.setString("productTo", productTo);
                                      prefs.setString("othersTo", othersTo);
                                    }
                                  })),
                          const Text("Engineer")
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final SharedPreferences prefs = await _prefs;
                      setState(() {
                        engineerTo = '0';
                        productTo = '1';
                        othersTo = '0';
                        copyToGroup = '2';
                        setCopyTo();
                      });
                      prefs.setString("engineerTo", engineerTo);
                      prefs.setString("productTo", productTo);
                      prefs.setString("othersTo", othersTo);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: copyToGroup,
                                  value: '2',
                                  onChanged: (value) async {
                                    final SharedPreferences prefs =
                                        await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        copyToGroup = value as String;
                                        engineerTo = '0';
                                        productTo = '1';
                                        othersTo = '0';
                                        setCopyTo();
                                      });
                                      prefs.setString("engineerTo", engineerTo);
                                      prefs.setString("productTo", productTo);
                                      prefs.setString("othersTo", othersTo);
                                    }
                                  })),
                          const Text("Product")
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final SharedPreferences prefs = await _prefs;
                      setState(() {
                        engineerTo = '0';
                        productTo = '0';
                        othersTo = '1';
                        copyToGroup = '3';
                        setCopyTo();
                      });
                      prefs.setString("engineerTo", engineerTo);
                      prefs.setString("productTo", productTo);
                      prefs.setString("othersTo", othersTo);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: copyToGroup,
                                  value: '3',
                                  onChanged: (value) async {
                                    final SharedPreferences prefs =
                                        await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        copyToGroup = value as String;
                                        engineerTo = '0';
                                        productTo = '0';
                                        othersTo = '1';
                                      });
                                      prefs.setString("engineerTo", engineerTo);
                                      prefs.setString("productTo", productTo);
                                      prefs.setString("othersTo", othersTo);
                                    }
                                  })),
                          const Text("Others")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(top: 16),
            //   child: const Text(
            //     "Approved by",
            //     style: TextStyle(
            //         fontFamily: 'Rubik',
            //         color: Color(0xFF404446),
            //         fontSize: 16,
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(top: 4),
            //   padding: const EdgeInsets.all(5),
            //   height: 40,
            //   decoration: BoxDecoration(
            //       border: Border.all(color: const Color(0xFF979C9E)),
            //       borderRadius: const BorderRadius.all(Radius.circular(5))),
            //   child: TextFormField(
            //     style: const TextStyle(
            //         fontFamily: 'Rubik',
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400),
            //     decoration: const InputDecoration(
            //         border: OutlineInputBorder(borderSide: BorderSide.none),
            //         suffixIcon: Icon(Icons.search),
            //         hintText: 'Type name',
            //         contentPadding: const EdgeInsets.only(top: 5, left: 5),
            //         hintStyle: TextStyle(
            //             fontFamily: 'Rubik',
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
