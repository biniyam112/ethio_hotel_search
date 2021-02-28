import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/default_button.dart';
import '../../../constants.dart';
import '../home/home_screen.dart';
import '../../../size_config.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key key}) : super(key: key);

  static String route = '/otp';

  @override
  Widget build(BuildContext context) {
    final String phone = ModalRoute.of(context).settings.arguments;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Home(phone: phone),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, @required this.phone}) : super(key: key);
  final String phone;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String verificationCode;
  @override
  void initState() {
    super.initState();
    formOneNode = FocusNode();
    formTwoNode = FocusNode();
    formThreeNode = FocusNode();
    formFourNode = FocusNode();
    formFiveNode = FocusNode();
    formSixNode = FocusNode();
    formOneController = TextEditingController();
    formTwoController = TextEditingController();
    formThreeController = TextEditingController();
    formFourController = TextEditingController();
    formFiveController = TextEditingController();
    formSixController = TextEditingController();
    otpDuration = Duration(minutes: 2);
    startOtpTimer();
    verifyPhone();
  }

  Timer startOtpTimer() {
    return otpExpireTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (otpDuration.inSeconds == 0) {
          otpExpireTimer.cancel();
        } else {
          otpDuration = Duration(seconds: otpDuration.inSeconds - 1);
        }
      },
    );
  }

  @override
  void dispose() {
    formOneNode.dispose();
    formOneController.dispose();
    formTwoNode.dispose();
    formTwoController.dispose();
    formThreeNode.dispose();
    formThreeController.dispose();
    formFourNode.dispose();
    formFourController.dispose();
    formFiveNode.dispose();
    formFiveController.dispose();
    formSixNode.dispose();
    formSixController.dispose();
    super.dispose();
    otpExpireTimer.cancel();
  }

  FocusNode formOneNode;
  FocusNode formTwoNode;
  FocusNode formThreeNode;
  FocusNode formFourNode;
  FocusNode formFiveNode;
  FocusNode formSixNode;
  TextEditingController formOneController;
  TextEditingController formTwoController;
  TextEditingController formThreeController;
  TextEditingController formFourController;
  TextEditingController formFiveController;
  TextEditingController formSixController;
  Timer otpExpireTimer;
  Duration otpDuration;

  @override
  Widget build(BuildContext context) {
    print(widget.phone);
    return SafeArea(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Expanded(
              child: Text(
                'Verify phone number',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpTextForm(
                  controller: formOneController,
                  currentNode: formOneNode,
                  nextNode: formTwoNode,
                ),
                OtpTextForm(
                  controller: formTwoController,
                  currentNode: formTwoNode,
                  nextNode: formThreeNode,
                  previousNode: formOneNode,
                ),
                OtpTextForm(
                  controller: formThreeController,
                  currentNode: formThreeNode,
                  nextNode: formFourNode,
                  previousNode: formTwoNode,
                ),
                OtpTextForm(
                  controller: formFourController,
                  currentNode: formFourNode,
                  previousNode: formThreeNode,
                  nextNode: formFiveNode,
                ),
                OtpTextForm(
                  controller: formFiveController,
                  currentNode: formFiveNode,
                  previousNode: formFourNode,
                  nextNode: formSixNode,
                ),
                OtpTextForm(
                  controller: formSixController,
                  currentNode: formSixNode,
                  previousNode: formFiveNode,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(20),
                horizontal: getProportionateScreenWidth(20),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: textLightColor,
                    height: 1.6,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'we have sent you 4 digit number to your phone number ',
                    ),
                    TextSpan(text: 'verify in : '),
                    TextSpan(
                      text:
                          '${otpDuration.inMinutes.toString()} : ${(otpDuration.inSeconds % 60).toString()}',
                      style: TextStyle(
                        color: textLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpacing(
              of: getProportionateScreenHeight(20),
            ),
            Container(
              height: getProportionateScreenHeight(60),
              width: SizeConfig.screenWidth - getProportionateScreenWidth(100),
              child: DefaultButton(
                title: 'Verify',
                onPress: () async {
                  String inputCode = formOneController.text +
                      formTwoController.text +
                      formThreeController.text +
                      formFourController.text +
                      formFiveController.text +
                      formSixController.text;
                  print(inputCode);
                  print(verificationCode);
                  try {
                    Firebase.initializeApp();
                    await FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: verificationCode,
                        smsCode: inputCode,
                      ),
                    )
                        .then(
                      (value) async {
                        print(value.user.phoneNumber);
                        if (value.user.phoneNumber != null) {
                          // TODO: thi is not working
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                user: value.user,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } catch (e) {
                    formSixNode.unfocus();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 20),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            e.toString(),
                            // 'Wrong verification code',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  void verifyPhone() async {
    String countryCode = '+251';
    // ? why is my app crashing???
    await Firebase.initializeApp();
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$countryCode${widget.phone}',
      timeout: Duration(minutes: 1),
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then(
          (value) {
            // if (value.user == null) {
            //todo : this is wrong have to do with firestore
            if (value.user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    user: value.user,
                  ),
                ),
              );
            }
          },
        );
      },
      verificationFailed: (error) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
    );
  }
}

class OtpTextForm extends StatelessWidget {
  const OtpTextForm({
    Key key,
    this.previousNode,
    this.nextNode,
    @required this.currentNode,
    @required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode previousNode;
  final FocusNode nextNode;
  final FocusNode currentNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(60),
      width: getProportionateScreenWidth(60),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        focusNode: currentNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: textLightColor,
              width: 3,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length > 1) {
            controller.text = value.substring(value.length - 1);
          }
          if (value.length == 1 && nextNode != null) {
            nextNode.requestFocus();
          }
          if (value.length == 0 && previousNode != null) {
            previousNode.requestFocus();
          }
        },
      ),
    );
  }
}
