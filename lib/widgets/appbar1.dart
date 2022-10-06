import 'package:flutter/material.dart';

import '../consts/colors.dart';

class MyAppBar1 extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset("assets/images/topIcon.png", width: 80),
      elevation: 0,
      backgroundColor: MyColors.appbarColor,
      centerTitle: true,
      leading: Container(),
      actions: [
        Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                size: 27,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black)],
              ));
        })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
