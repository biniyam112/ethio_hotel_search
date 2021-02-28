import 'package:flutter/material.dart';
import '../../components/default_button.dart';
import '../signup/signup_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'splash_screen_data.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  static String route = '/splash';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/welcome.jpg'), context);
    precacheImage(AssetImage('assets/images/book_hotel.jpg'), context);
    precacheImage(AssetImage('assets/images/book_easily.jpg'), context);
    return SafeArea(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: PageView.builder(
                itemCount: splashData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: animationDuration,
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    color: splashPageColor[index],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSpacing(of: 100),
                        Text(
                          splashData[index]['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(38),
                          ),
                        ),
                        verticalSpacing(of: 20),
                        Text(
                          splashData[index]['text'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textLightColor,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Image.asset(
                            splashData[index]['imagepath'],
                          ),
                        ),
                        Spacer(),
                        if (index == 2)
                          Container(
                            height: getProportionateScreenHeight(80),
                            width: SizeConfig.screenWidth -
                                getProportionateScreenWidth(100),
                            margin: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                            ),
                            padding: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(20),
                            ),
                            child: DefaultButton(
                              title: 'Continue',
                              onPress: () {
                                Navigator.pushNamed(
                                    context, SignUpScreen.route);
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: getProportionateScreenHeight(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    splashData.length,
                    (index) => Padding(
                      padding: EdgeInsets.all(3.0),
                      child: AnimatedContainer(
                        duration: animationDuration,
                        height: 6,
                        width: currentPage == index ? 12 : 6,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? primaryColor
                              : textLightColor.withOpacity(.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
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
