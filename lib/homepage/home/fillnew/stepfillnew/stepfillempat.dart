// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillEmpat extends StatefulWidget {
  const StepFillEmpat({ Key? key }) : super(key: key);

  @override
  _StepFillEmpatState createState() => _StepFillEmpatState();
}

class _StepFillEmpatState extends State<StepFillEmpat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column( children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text('Item Checking',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Rubik'
          ),),
        ),
        Container(
         width: MediaQuery.of(context).size.width,
         padding: EdgeInsets.all(10),
         margin: EdgeInsets.only(top: 10),
         alignment: Alignment.center,
         decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(10)),
         color: Colors.blue
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5),
              child:  Icon( 
              Icons.add_circle_outline,
              color: Colors.white,
              size: 30,),
            ),
             Text('Add item',
             textAlign: TextAlign.center,
             style: TextStyle(
                fontFamily: 'Rubik',
                color: Colors.white,
                fontSize: 12
            ),),
           
          ],
        ),
        )

      ],),
    );
  }
}