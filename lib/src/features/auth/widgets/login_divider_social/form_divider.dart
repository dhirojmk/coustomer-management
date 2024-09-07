import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({super.key, required this.dividerText});
final String dividerText;

  @override
  Widget build(BuildContext context) {

    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(
            color:  TColors.darkGray,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(orSignInWith,
            style: Theme.of(context).textTheme.labelMedium),
        Flexible(
          child: Divider(
            color:  TColors.darkGray ,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
