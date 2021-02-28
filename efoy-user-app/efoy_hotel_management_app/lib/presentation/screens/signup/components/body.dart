import '../../home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
import '../../../../constants.dart';
import '../../otp/otp_screen.dart';

import '../../../../size_config.dart';

class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.route);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(10),
                right: getProportionateScreenWidth(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'skip ',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Text(
            'enter phone number\n to start building your profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textLightColor,
            ),
          ),
          verticalSpacing(
            of: getProportionateScreenWidth(40),
          ),
          TextInputFiedld(
            labelText: 'Phone',
            phoneChanged: (phone) {
              phoneNumber = phone;
            },
          ),
          verticalSpacing(of: getProportionateScreenHeight(40)),
          Container(
            height: getProportionateScreenHeight(60),
            width: SizeConfig.screenWidth - getProportionateScreenWidth(100),
            child: DefaultButton(
              title: 'Enter',
              onPress: () {
                Navigator.pushNamed(
                  context,
                  OTPScreen.route,
                  arguments: phoneNumber,
                );
              },
            ),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}

class TextInputFiedld extends StatelessWidget {
  const TextInputFiedld({
    Key key,
    @required this.labelText,
    @required this.phoneChanged,
  }) : super(key: key);
  final String labelText;
  final Function phoneChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      width: SizeConfig.screenWidth - getProportionateScreenWidth(100),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: phoneChanged,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixText: '+251  ',
          prefixStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: textLightColor,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: primaryColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
