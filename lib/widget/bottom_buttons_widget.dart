import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: size.width * 0.95,
            child: TextButton.icon(
                icon: FaIcon(FontAwesomeIcons.plus, color: Color(0xFF059BFF)),
                label: Text('Post',
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    backgroundColor: Color(0xFF19232B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  print('Pressed');
                }))
      ],
    );
  }
}
