import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wistv/consts/colors.dart';

import 'list_page.dart';

class Drawerz extends StatefulWidget {
  const Drawerz({Key? key}) : super(key: key);

  @override
  State<Drawerz> createState() => _DrawerzState();
}

class _DrawerzState extends State<Drawerz> {
  String _selectedMenuItem = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: MyColors.drawerBackgroundColor,
      width: Get.width / 1.5,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(children: [
          Image.asset("assets/images/topIcon.png", width: Get.width / 4),
          const SizedBox(height: 30),
          _menuItem(
              text: "Film Türleri",
              icon: Icons.local_movies_outlined,
              isDrowdown: true),
          _subItem1(),
          _menuItem(
              text: "Dizi Türleri", icon: Icons.local_movies, isDrowdown: true),
          _subItem2(),
          _menuItem(text: "Anime", icon: Icons.air_sharp, isDrowdown: false),
          _menuItem(
              text: "Çizgi Film",
              icon: Icons.smart_toy_outlined,
              isDrowdown: false),
          _menuItem(
            text: "İletişim",
            icon: Icons.mail,
            isDrowdown: false,
          )
        ]),
      ),
    );
  }

  Widget _subItem1() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 700),
      opacity: _selectedMenuItem == "Film Türleri" ? 1 : 0,
      curve: Curves.easeInOut,
      child: Visibility(
        visible: _selectedMenuItem == "Film Türleri",
        child: Wrap(
          children: [
            _subMenuItem(text: "Animasyon", filterMenu: "Filmler"),
            _subMenuItem(text: "Bilim Kurgu", filterMenu: "Filmler"),
            _subMenuItem(text: "Fantastik", filterMenu: "Filmler"),
            _subMenuItem(text: "Gizem", filterMenu: "Filmler"),
            _subMenuItem(text: "Komedi", filterMenu: "Filmler"),
            _subMenuItem(text: "Polisiye", filterMenu: "Filmler"),
            _subMenuItem(text: "Romantik", filterMenu: "Filmler"),
            _subMenuItem(text: "Suç", filterMenu: "Filmler"),
            _subMenuItem(text: "Western", filterMenu: "Filmler"),
            _subMenuItem(text: "Aksiyon", filterMenu: "Filmler"),
            _subMenuItem(text: "Belgesel", filterMenu: "Filmler"),
            _subMenuItem(text: "Dram", filterMenu: "Filmler"),
            _subMenuItem(text: "Gerilim", filterMenu: "Filmler"),
            _subMenuItem(text: "Hint", filterMenu: "Filmler"),
            _subMenuItem(text: "Korku", filterMenu: "Filmler"),
            _subMenuItem(text: "Psikolojik", filterMenu: "Filmler"),
            _subMenuItem(text: "Savaş", filterMenu: "Filmler"),
            _subMenuItem(text: "Tarih", filterMenu: "Filmler"),
            _subMenuItem(text: "Yerli", filterMenu: "Filmler"),
          ],
        ),
      ),
    );
  }

  Widget _subItem2() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 700),
      opacity: _selectedMenuItem == "Dizi Türleri" ? 1 : 0,
      curve: Curves.easeInOut,
      child: Visibility(
        visible: _selectedMenuItem == "Dizi Türleri",
        child: Wrap(
          children: [
            _subMenuItem(text: "Exxen", filterMenu: "Diziler"),
            _subMenuItem(text: "BluTV", filterMenu: "Diziler"),
            _subMenuItem(text: "Netflix", filterMenu: "Diziler"),
            _subMenuItem(text: "Gain", filterMenu: "Diziler"),
            _subMenuItem(text: "Animasyon", filterMenu: "Diziler"),
            _subMenuItem(text: "Bilim Kurgu", filterMenu: "Diziler"),
            _subMenuItem(text: "Fantastik", filterMenu: "Diziler"),
            _subMenuItem(text: "Gizem", filterMenu: "Diziler"),
            _subMenuItem(text: "Komedi", filterMenu: "Diziler"),
            _subMenuItem(text: "Polisiye", filterMenu: "Diziler"),
            _subMenuItem(text: "Romantik", filterMenu: "Diziler"),
            _subMenuItem(text: "Suç", filterMenu: "Diziler"),
            _subMenuItem(text: "Western", filterMenu: "Diziler"),
            _subMenuItem(text: "Aksiyon", filterMenu: "Diziler"),
            _subMenuItem(text: "Belgesel", filterMenu: "Diziler"),
            _subMenuItem(text: "Dram", filterMenu: "Diziler"),
            _subMenuItem(text: "Gerilim", filterMenu: "Diziler"),
            _subMenuItem(text: "Hint", filterMenu: "Diziler"),
            _subMenuItem(text: "Korku", filterMenu: "Diziler"),
            _subMenuItem(text: "Psikolojik", filterMenu: "Diziler"),
            _subMenuItem(text: "Savaş", filterMenu: "Diziler"),
            _subMenuItem(text: "Tarih", filterMenu: "Diziler"),
            _subMenuItem(text: "Nostalji", filterMenu: "Diziler"),
          ],
        ),
      ),
    );
  }

  Widget _subMenuItem({required String text, required String filterMenu}) {
    return InkWell(
      onTap: () => setState(() {
        _selectedMenuItem = "";
        Scaffold.of(context).closeDrawer();
        Get.to(
          () => ListPage(),
          arguments: {"text": text, "filterMenu": filterMenu, "isMenu": true},
          transition: Transition.fade,
        );
      }),
      child: Container(
        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 10, top: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: MyColors.softWhite,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(
      {required String text,
      required IconData icon,
      required bool isDrowdown}) {
    return InkWell(
      onTap: () => setState(() {
        if (_selectedMenuItem == text) {
          _selectedMenuItem = "";
        } else {
          _selectedMenuItem = text;
        }
        if (!isDrowdown && text == "İletişim") {
          Scaffold.of(context).closeDrawer();
          Get.snackbar(
              "İletişim", "Mail: omer670067@gmail.com\nTelegram: bluruwis",
              backgroundColor: Colors.blueGrey[800], colorText: Colors.white);
        } else if (!isDrowdown) {
          Scaffold.of(context).closeDrawer();
          Get.to(
            () => ListPage(),
            arguments: {"text": text, "filterMenu": null, "isMenu": true},
            transition: Transition.fade,
          );
        }
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            isDrowdown
                ? Icon(
                    _selectedMenuItem.isEmpty || _selectedMenuItem != text
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.white,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
