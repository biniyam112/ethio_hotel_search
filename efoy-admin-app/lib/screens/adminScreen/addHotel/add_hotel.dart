import 'package:google_fonts/google_fonts.dart';
import 'package:hotels/constants.dart';

import './components/body.dart';
import 'package:flutter/material.dart';

class AddHotelsScreen extends StatelessWidget {
  const AddHotelsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          'EFOY admin',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
