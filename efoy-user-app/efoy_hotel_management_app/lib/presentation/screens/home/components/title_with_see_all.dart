import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TitleWithSeeallButton extends StatelessWidget {
  const TitleWithSeeallButton({
    Key key,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: textLightColor.withOpacity(.8),
              ),
            ),
            Row(
              children: [
                Text(
                  'see all',
                  style: TextStyle(
                    fontSize: 16,
                    color: textLightColor.withOpacity(.8),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: textLightColor.withOpacity(.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
