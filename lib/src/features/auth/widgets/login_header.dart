import 'package:flutter/material.dart';

import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        const Image(
          height: 120,
          image: AssetImage(tLoginImage),
        ),
        const SizedBox(
          height: tDefaultSize,
        ),
        Text(tLoginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(
          height: tDefaultSize,
        ),
        Text(tLoginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
