// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldelapan.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldua.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillempat.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillenam.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilllima.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillsatu.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltiga.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltujuh.dart';
import 'package:flutter/material.dart';

class FillNew extends StatefulWidget {
  const FillNew({Key? key}) : super(key: key);

  @override
  _FillNewState createState() => _FillNewState();
}

class _FillNewState extends State<FillNew> {
  final GlobalKey<StepFillSatuState> _keyFillSatu = GlobalKey();

  int _currentStep = 0;
  final int _stepTotal = 8;
  int _stepClicked = 1;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 7 ? setState(() => _currentStep += 1) : null;
    print(_currentStep);
    // if(_stepClicked != 8) {
    //   setState(() => _stepClicked += 1);
    // }
    // _keyFillSatu.currentState!.saveFillNewSatu();
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    if (_stepClicked != 1) {
      setState(() => _stepClicked -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEDB),
        elevation: 1,
        title: Text(
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                          title: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 16),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Information',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Symbol',
                                        style: TextStyle(
                                            color: Color(0xFF404446),
                                            fontSize: 16,
                                            fontFamily: 'Rubik',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                            text: ' * ',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text: '(required to filled)',
                                            style: TextStyle(
                                                color: Color(0xFF404446),
                                                fontSize: 16,
                                                fontFamily: 'Rubik',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ]),
                                  ),
                                ),
                                Divider(
                                  height: 8,
                                  color: Color(0xFFCDCFD0),
                                ),
                                Text(
                                  "Rule line stop",
                                  style: TextStyle(
                                      color: Color(0xFF404446),
                                      fontSize: 16,
                                      fontFamily: 'Rubik',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '1. > 10 minutes = G/L require e-sign > 15'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '2. minutes = C/L require e-sign > 20'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '3. minutes = MGR require e-sign + cost >'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '4. 1 million > 40 minutes = GM require e-sign'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                          ],
                        ));
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () => cancel(),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF00AEDB)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF00AEDB)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => continued(),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFF00AEDB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                "Next $_stepClicked/$_stepTotal",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                steps: [
                  Step(
                    title: Text(''),
                    content: StepFillSatu(),
                    // isActive: _currentStep >= 0,
                    // state: _currentStep >= 0
                    //     ? StepState.complete
                    //     : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
