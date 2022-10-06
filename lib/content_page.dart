import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wistv/models/season_model.dart';
import 'package:wistv/player_page.dart';
import 'package:wistv/webview_page.dart';
import 'package:wistv/widgets/appbar2.dart';
import 'package:wistv/widgets/titlebar.dart';
import 'consts/colors.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late Map<String, dynamic> _startValue;
  late SeasonModel _seasonModel;
  String _onHover = "";
  int _currentSeasonIndex = 0;

  @override
  void initState() {
    _startValue = Get.arguments;
    _seasonModel = SeasonModel(startValue: _startValue);
    super.initState();
  }

  Future _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _seasonModel.html.isEmpty
        ? Scaffold(
            appBar: const MyAppBar2(),
            backgroundColor: MyColors.menuButtonColor,
            body: _dynamicContent())
        : WebViewPage(htmlString: _seasonModel.html);
  }

  SingleChildScrollView _dynamicContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          TitleBar(title: _seasonModel.title),
          _info(text: _seasonModel.description),
          if (_seasonModel.series)
            for (var s = 0; s < _seasonModel.seasonNumber; s++)
              if (_currentSeasonIndex == s)
                for (var c = 0;
                    c < _seasonModel.getChapterNumber(seasonNumber: s);
                    c++)
                  _season(season: s + 1, chapter: c + 1),
          if (!_seasonModel.series)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () => Get.to(
                  () => const PlayerPage(),
                  arguments: _seasonModel.season["0"]["chapters"]["0"],
                  transition: Transition.fade,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.withOpacity(0.4),
                  minimumSize: Size(Get.width / 1.2, 38),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "HEMEN İZLE",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _season({required int season, required int chapter}) {
    return InkWell(
      onTapDown: (_) => setState(() => _onHover = "$season-$chapter"),
      onTap: () {
        setState(() => _onHover = "$season-$chapter");
        Get.to(
          () => const PlayerPage(),
          arguments: _seasonModel.season[(season - 1).toString()]["chapters"]
              [(chapter - 1).toString()],
          transition: Transition.fade,
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: _onHover == "$season-$chapter"
                ? Colors.blue.withOpacity(0.2)
                : Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(Icons.crop_square, color: MyColors.softWhite),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "$season. Sezon $chapter. Bölüm",
                style: TextStyle(
                    color: MyColors.softWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _info({required String text}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          color: MyColors.backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          _image(),
          Text(text, style: TextStyle(fontSize: 15, color: MyColors.softWhite)),
          Container(
            color: Colors.black.withOpacity(0.3),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tür: ${_seasonModel.category[0]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Text(
                  "IMDB: ${_seasonModel.imdb}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          if (_seasonModel.series)
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < _seasonModel.seasonNumber; i++)
                    _chooseSeason(seasonNum: i),
                ],
              ),
            )
        ],
      ),
    );
  }

  InkWell _chooseSeason({required int seasonNum}) {
    return InkWell(
      onTap: () => setState(() {
        _onHover = "";
        _currentSeasonIndex = seasonNum;
      }),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: _currentSeasonIndex == seasonNum
                  ? Colors.greenAccent.withOpacity(0.8)
                  : MyColors.softWhite,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Sezon ${seasonNum + 1}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Container _image() {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.network(_seasonModel.image, width: Get.width / 3),
            InkWell(
              onTap: () => _launchUrl(_seasonModel.trailer),
              child: Container(
                width: Get.width / 3,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  "Fragmanı izle",
                  style: TextStyle(
                      color: MyColors.softBlue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
