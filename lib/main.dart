import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wistv/consts/colors.dart';
import 'package:wistv/controllers/data_controller.dart';
import 'package:wistv/funcs/fetch_html.dart';
import 'package:wistv/funcs/firebase_auth.dart';
import 'package:wistv/list_page.dart';
import 'package:wistv/drawer_page.dart';
import 'package:wistv/models/season_model.dart';
import 'package:wistv/widgets/appbar1.dart';
import 'content_page.dart';
import 'widgets/share_with_friends.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _searchBoxController = TextEditingController();
  final _dataCtrl = Get.put(DataController());
  @override
  void initState() {
    firebaseAuth().then((_) => _dataCtrl.getChoiceData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: SafeArea(
        child: Scaffold(
          drawer: const Drawerz(),
          appBar: const MyAppBar1(),
          body: Container(
            color: MyColors.editorsChoiceBgColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: MyColors.backgroundColor,
                    child: Column(
                      children: [
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              _menuButton(text: "SPOR"),
                              _menuButton(text: "Filmler"),
                              _menuButton(text: "Diziler"),
                              _menuButton(text: "Canlı TV"),
                              _menuButton(text: "Radyo"),
                              _menuButton(text: "Müzik"),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 17),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.searchBoxColor),
                          child: TextField(
                            controller: _searchBoxController,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                Get.to(() => ListPage(),
                                    arguments: {
                                      "text": value,
                                      "filterMenu": "Ara",
                                      "isMenu": false
                                    },
                                    transition: Transition.fade);
                              }
                            },
                            style: TextStyle(color: MyColors.softWhite),
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.search,
                                  color: MyColors.blue,
                                ),
                                border: InputBorder.none,
                                hintText: "Film veya dizi ismi girin",
                                hintStyle: TextStyle(
                                    color: MyColors.searchBoxHintColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ShareWithFriends(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: MyColors.editorsChoiceColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "EDİTÖRÜN SEÇİMİ",
                            style: TextStyle(
                                color: MyColors.softBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        Obx(
                          () => _dataCtrl.choiceData.value == null ||
                                  _dataCtrl.choiceData.value!.isEmpty
                              ? Container(
                                  height: 300,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                      color: MyColors.softWhite),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        viewportFraction: 0.6,
                                        aspectRatio: 1.3,
                                        enableInfiniteScroll: true,
                                        autoPlayCurve: Curves.easeIn,
                                      ),
                                      items: [
                                        for (SeasonModel model
                                            in _dataCtrl.choiceData.value ?? [])
                                          Builder(
                                            builder: (BuildContext context) {
                                              return InkWell(
                                                onTap: () => Get.to(
                                                  () => ContentPage(),
                                                  arguments: {
                                                    "title": model.title,
                                                    "category":
                                                        model.category[0],
                                                    "imdb": model.imdb,
                                                    "image": model.image,
                                                    "trailer": model.trailer,
                                                    "season": model.season,
                                                    "description":
                                                        model.description,
                                                    "series": model.series,
                                                    "html": model.html
                                                  },
                                                  transition: Transition.fade,
                                                ),
                                                child:
                                                    Image.network(model.image),
                                              );
                                            },
                                          )
                                      ]),
                                ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton({required String text}) {
    return InkWell(
      onTap: () {
        if (text == "SPOR" ||
            text == "Canlı TV" ||
            text == "Radyo" ||
            text == "Müzik") {
          fetchHtmlContent(text);
        } else {
          Get.to(() => ListPage(),
              arguments: {"text": text, "filterMenu": text, "isMenu": true},
              transition: Transition.fade);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 5, right: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: MyColors.menuButtonColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(text,
              style: TextStyle(color: MyColors.textColor, fontSize: 18)),
        ),
      ),
    );
  }
}
