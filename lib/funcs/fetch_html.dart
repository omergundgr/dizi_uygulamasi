import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wistv/webview_page.dart';

final _firestoreHtml = FirebaseFirestore.instance.collection("html");

Future fetchHtmlContent(String category) async {
  if (category == "Canlı TV") {
    category = "tv";
  } else if (category == "SPOR") {
    category = "spor";
  } else if (category == "Radyo") {
    category = "radyo";
  } else if (category == "Müzik") {
    category = "muzik";
  }
  await _firestoreHtml.doc(category).get().then((value) => Get.to(
      () => WebViewPage(htmlString: value.data()!["html"]),
      transition: Transition.fade));
}
