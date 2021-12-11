import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:e_cm/homepage/home/history/model/historydailymodel.dart';
import 'package:e_cm/homepage/home/history/service/get_history_daily.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/notification/view/detailecm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<HistoryDaily> _listDaily = [];
  DateTime _fromDate = DateTime.now();
  String dateSelected = 'DD/MM/YYYY';

  bool tabAll = false;
  bool tabDaily = true;
  bool tabMontly = false;

  Future<List<HistoryDaily>> getListDaily() async {
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    final String date = _fromDate.format("Y-m-d");
    try {
      var response = await getHistoryDaily(tokenUser, date, date);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listDaily = data.map((e) => HistoryDaily.fromJson(e)).toList();
          print("===== list approved =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: 'Periksa jaringan internet anda',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      }
    } catch (e) {
      print(e);
    }
    return _listDaily;
  }

  void getDateFromDialog() async {
    final prefs = await _prefs;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2022))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        _fromDate = value;
        final String date = _fromDate.format("Y-m-d");

        // String date = _fromDate.format("Y-m-d");
        setState(() {
          dateSelected = date;
        });
        print(dateSelected);
      }
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "History E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            height: 40,
            // color: Colors.redAccent,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      // addMasjid();
                    });
                    tabAll = true;
                    tabDaily = false;
                    tabMontly = false;
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFF00AEDB),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color:
                              tabAll == true ? Color(0xFF00AEDB) : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      // height: 20,
                      child: Text(
                        "All",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          color:
                              tabAll == true ? Colors.white : Color(0xFF00AEDB),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      // addMasjid();
                    });
                    tabAll = false;
                    tabDaily = true;
                    tabMontly = false;
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFF00AEDB),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: tabDaily == true
                              ? Color(0xFF00AEDB)
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      // height: 20,
                      child: Text(
                        "Today",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          color: tabDaily == true
                              ? Colors.white
                              : Color(0xFF00AEDB),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      // addMasjid();
                    });
                    tabAll = false;
                    tabDaily = false;
                    tabMontly = true;
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFF00AEDB),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: tabMontly == true
                              ? Color(0xFF00AEDB)
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      // height: 20,
                      child: Text(
                        "Monthly",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          color: tabMontly == true
                              ? Colors.white
                              : Color(0xFF00AEDB),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              // color: Colors.amberAccent,
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _listDaily.isEmpty ? 0 : _listDaily.length,
                itemBuilder: (context, i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF00AEDB),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/ario.png"))),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                          ),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: _listDaily[i]
                                                    .nama
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Color(0xFF00AEDB),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            TextSpan(
                                                text: ' Making E-CM Card',
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14,
                                                    color: Color(0xFF6C7072))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        _listDaily[i].waktu.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 10,
                                            color: Color(0xFF979C9E)),
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsets.only(top: 22),
                                      //   child: Row(
                                      //     children: [
                                      //       InkWell(
                                      //         onTap: () {
                                      //           // Navigator.of(context).push(MaterialPageRoute(
                                      //           //     builder: (context) => DetailEcm(
                                      //           //           notifId: _listDaily[i]
                                      //           //               .notifEcmId
                                      //           //               .toString(),
                                      //           //         )));
                                      //           // print("ok");
                                      //         },
                                      //         child: Container(
                                      //           width: 63,
                                      //           height: 24,
                                      //           decoration: BoxDecoration(
                                      //               border: Border.all(
                                      //                   color: const Color(0xFF00AEDB)),
                                      //               borderRadius: const BorderRadius.all(
                                      //                   Radius.circular(5))),
                                      //           child: const Center(
                                      //             child: Text(
                                      //               "Review",
                                      //               style: TextStyle(
                                      //                   fontFamily: 'Rubik',
                                      //                   fontSize: 12,
                                      //                   fontWeight: FontWeight.w400),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         width: 8,
                                      //       ),
                                      //       Container(
                                      //         width: 63,
                                      //         height: 24,
                                      //         decoration: BoxDecoration(
                                      //             color: Color(0xFF00AEDB),
                                      //             borderRadius:
                                      //                 BorderRadius.all(Radius.circular(5))),
                                      //         child: Center(
                                      //           child: Text(
                                      //             "Approve",
                                      //             style: TextStyle(
                                      //                 fontFamily: 'Rubik',
                                      //                 color: Colors.white,
                                      //                 fontSize: 12,
                                      //                 fontWeight: FontWeight.w400),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         width: 8,
                                      //       ),
                                      //       Container(
                                      //         width: 63,
                                      //         height: 24,
                                      //         decoration: BoxDecoration(
                                      //             color: Color(0xFFFF0000),
                                      //             borderRadius:
                                      //                 BorderRadius.all(Radius.circular(5))),
                                      //         child: Center(
                                      //           child: Text(
                                      //             "Decline",
                                      //             style: TextStyle(
                                      //                 fontFamily: 'Rubik',
                                      //                 color: Colors.white,
                                      //                 fontSize: 12,
                                      //                 fontWeight: FontWeight.w400),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
