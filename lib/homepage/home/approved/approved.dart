// ignore_for_file: prefer_const_constructors

import 'package:e_cm/homepage/home/model/approvedmodel.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/notification/view/detailecm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApprovedEcm extends StatefulWidget {
  const ApprovedEcm({Key? key}) : super(key: key);

  @override
  _ApprovedEcmState createState() => _ApprovedEcmState();
}

class _ApprovedEcmState extends State<ApprovedEcm> {
  List<ApprovedModel> _listApproved = [];

  Future<List<ApprovedModel>> getApprovedData() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    String? idUser = prefs.getString("idKeyUser").toString();

    try {
      var response = await getApproved(idUser, tokenUser);
      print("response apporoved -> ${response['response']}");
      if (response['response']['status'] == 200) {
        var data = response['data'] as List;
        _listApproved = data.map((e) => ApprovedModel.fromJson(e)).toList();
        print("===== list approved =====");
        print(data.length);
        // print(response['data']);
        print("===== || =====");
      } else {
        Fluttertoast.showToast(
            msg: 'Periksa jaringan internet anda',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
    } catch (e) {
      print("approved exception $e");
    }
    return _listApproved;
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    super.initState();
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
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getApprovedData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ApprovedModel>> snapshot) {
            if (snapshot.hasData) {
              return _listApproved.isEmpty
                  ? _buildErrorResultWidget()
                  : _buildBodyWidget();
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Wrap(
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _listApproved.length,
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                        color: Color(0xFF00AEDB),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/ario.png"))),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                text: 'E-CM Card from ',
                                style: TextStyle(color: Color(0xFF6C7072))),
                            TextSpan(
                                text: _listApproved[i].nama.toString(),
                                style: TextStyle(
                                    color: Color(0xFF00AEDB),
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const Text(
                        "1 hour ago",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 10,
                            color: Color(0xFF979C9E)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailEcm(
                                          notifId: _listApproved[i]
                                              .notifEcmId
                                              .toString(),
                                        )));
                              },
                              child: Container(
                                width: 63,
                                height: 24,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00AEDB)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Center(
                                  child: Text(
                                    "Review",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Visibility(
                              visible: _listApproved[i].status != "decline",
                              child: Container(
                                width: 63,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: _listApproved[i].status != "accept"
                                        ? Color(0xFF00AEDB)
                                        : Color(0xFF979C9E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    _listApproved[i].status != "accept"
                                        ? "Approve"
                                        : "Approved",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Visibility(
                              visible: _listApproved[i].status != "accept",
                              child: Container(
                                width: 63,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: _listApproved[i].status != "decline"
                                        ? Color(0xFFFF0000)
                                        : Color(0xFF979C9E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    _listApproved[i].status != "decline"
                                        ? "Decline"
                                        : "Declined",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorResultWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Wrap(
          children: const [
            Text("Data E-CM card untuk user ini tidak ada"),
          ],
        ),
      ),
    );
  }
}
