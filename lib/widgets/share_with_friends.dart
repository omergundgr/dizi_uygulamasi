import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts/colors.dart';
import 'package:clipboard/clipboard.dart';

class ShareWithFriends extends StatelessWidget {
  const ShareWithFriends({
    Key? key,
  }) : super(key: key);

  _copyShareLink() {
    FlutterClipboard.copy('https://google.com/').then((_) => Get.snackbar(
        "Kopyalandı",
        "Uygulama linki kopyalandı. Şimdi arkadaşlarınla paylaşabilirsin.",
        backgroundColor: Colors.green[800],
        colorText: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors.infoBoxColor,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: "Değerli ",
                  style: TextStyle(color: MyColors.softWhite, fontSize: 16),
                  children: [
                    TextSpan(
                        text: "WisTV Ailesi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: MyColors.softWhite)),
                    TextSpan(
                      text:
                          ", Mobil Uygulamamızın daha fazla gelişebilmesi için arkadaşlarınızla paylaşabilirsiniz.",
                      style: TextStyle(
                        color: MyColors.softWhite,
                        fontSize: 16,
                      ),
                    )
                  ]),
            ),
            InkWell(
              onTap: () => _copyShareLink(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: MyColors.shareButtonColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Şimdi Paylaş",
                      style: TextStyle(
                          color: MyColors.softWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.phone_android_outlined,
                      color: MyColors.softWhite,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
