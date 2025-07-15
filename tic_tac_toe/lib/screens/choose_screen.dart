import 'package:flutter/material.dart';
import 'game_screen.dart';

class ChooseScreen extends StatefulWidget {
  final bool isAi;
  const ChooseScreen({super.key, required this.isAi});
  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  String selectedSide = 'X';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pick your side',
              style: TextStyle(fontSize: 24, fontFamily: 'KOMIKAX_'),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image(
                      image: AssetImage('assets/img2.png'),
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        value: 'x',
                        groupValue: selectedSide,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            selectedSide = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Image(
                      image: AssetImage('assets/img1.png'),
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        value: 'O',
                        groupValue: selectedSide,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            selectedSide = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(300, 50),
              padding: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,
              shadowColor: Colors.grey,
          ),
              onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> GameScreen(playerSide:selectedSide, isAi: widget.isAi)));
            }, 
            child: Text('Continue',style: TextStyle(fontSize: 24,fontFamily: 'KOMIKAX_',
            color: Colors.black54),))
          ],
        ),
      ),
    );
  }
}
