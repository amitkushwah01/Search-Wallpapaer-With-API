// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Detail extends StatelessWidget
{
  var i;
  Detail({required this.i ,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body:Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(i,fit: BoxFit.cover,)
          ),
          Positioned(top: 80,left: 5,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 35,),
                  Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 35,),
                ],
              )
            )
          ),
        ],
      )
    );
  }
}