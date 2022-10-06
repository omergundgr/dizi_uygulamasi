import 'package:flutter/material.dart';

import '../consts/colors.dart';

class MyAppBar2 extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.appbarColor,
      title: Image.asset("assets/images/topIcon.png", width: 80),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
