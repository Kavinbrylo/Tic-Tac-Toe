import 'package:flutter/material.dart';
import 'choose_screen.dart';
class PlayMode extends StatelessWidget {

@override
Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Color(0xFFF6F6F6),
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/img2.png',)
            ),
            Image(image: AssetImage('assets/img1.png',)
            ),
          ],
        ),
        SizedBox(height: 50),
        Text(
          'Choose your Play Mode',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(300, 50),
            padding: EdgeInsets.symmetric(vertical: 10),
            elevation: 10,
            shadowColor: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> ChooseScreen(isAi: true)));
          },
          child: Text('With Ai',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'KOMIKAX_',
            color: Colors.white,
          ),),
        ),
        SizedBox(height: 30,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: Size(300, 50),
            padding: EdgeInsets.symmetric(vertical: 10),
            elevation: 10,
            shadowColor: Colors.grey,
          ),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> ChooseScreen(isAi: false)));
          },
          child: Text('With Friends',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'KOMIKAX_',
            color: Colors.black,
          ),),
        ),
      ],
    ),
  ),


);
}
}