import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.title,
    @required this.onPress,
    this.textFontSize = 20,
  }) : super(key: key);

  final String title;
  final double textFontSize;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(
        getProportionateScreenWidth(10),
      ),
      splashColor: buttonSplashColor.withOpacity(.8),
      child: Ink(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(10),
          ),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(10),
            ),
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(fontSize: textFontSize),
            ),
          ),
        ),
      ),
    );
  }
}
