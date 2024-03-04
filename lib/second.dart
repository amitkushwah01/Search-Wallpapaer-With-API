// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget
{
  var j;
  SecondPage({required this.j});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body:Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(j,fit: BoxFit.cover,)
          ),
          Positioned(top: 250,left: 5,
            child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 50,)
          ),
          Positioned(
            top: 250,left: 350,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage(j: j)));
              },
              child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 50,)
            )
          )
        ],
      )
    );
  }
}