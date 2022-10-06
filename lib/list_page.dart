import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wistv/consts/colors.dart';
import 'package:wistv/content_page.dart';
import 'package:wistv/controllers/data_controller.dart';
import 'package:wistv/models/season_model.dart';
import 'package:wistv/widgets/appbar2.dart';
import 'package:wistv/widgets/titlebar.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final DataController _dataCtrl = Get.find();
  late Map _startValue;
  String _text = "";
  String _filterMenu = "";
  int _onHoverIndex = -1;

  @override
  void initState() {
    _startValue = Get.arguments;
    if (_startValue['filterMenu'] == null) {
      _filterMenu = "";
    } else {
      _filterMenu = _startValue['filterMenu'];
    }
    _text = _startValue['text'];

    _dataCtrl.addToSeriesData(
        data: _startValue,
        isSeries: _filterMenu == "Diziler",
        clickCategory: _text,
        isMenu: _startValue["isMenu"]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.menuButtonColor,
      appBar: const MyAppBar2(),
      body: Column(
        children: [
          Obx(
            () {
              return Expanded(
                child: _dataCtrl.seriesData.value == null
                    ? Center(
                        child: CircularProgressIndicator(
                        color: MyColors.softWhite,
                      ))
                    : _dataCtrl.seriesData.value!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueGrey.withOpacity(0.8),
                                  size: 70,
                                ),
                                Text(
                                  "- ${_filterMenu.isEmpty ? _text : _filterMenu == _text ? _text : "$_filterMenu / $_text"} -\nAradığınız sonuca uygun içerik bulunamadı.\nDaha kısa bir arama metni girebilir veya farklı içeriklere göz atabilirsiniz.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MyColors.softWhite, fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _dataCtrl.seriesData.value!.length,
                            itemBuilder: (context, index) {
                              final SeasonModel data =
                                  _dataCtrl.seriesData.value![index];
                              return _listItem(index,
                                  title: data.title,
                                  description: data.description,
                                  category: data.category[0],
                                  imdb: data.imdb,
                                  image: data.image,
                                  trailer: data.trailer,
                                  season: data.season,
                                  series: data.series,
                                  html: data.html);
                            },
                          ),
              );
            },
          ),
        ],
      ),
    );
  }

  InkWell _listItem(int index,
      {required String title,
      required String category,
      required String imdb,
      required String image,
      required String trailer,
      required String description,
      required Map season,
      required bool series,
      required String html}) {
    return InkWell(
      onTapDown: (_) => setState(() => _onHoverIndex = index),
      onTap: () {
        setState(() => _onHoverIndex = index);
        Get.to(
          () => ContentPage(),
          arguments: {
            "title": title,
            "category": category,
            "imdb": imdb,
            "image": image,
            "trailer": trailer,
            "season": season,
            "description": description,
            "series": series,
            "html": html
          },
          transition: Transition.fade,
        );
      },
      child: Column(
        children: [
          index == 0
              ? TitleBar(
                  title: _filterMenu.isEmpty
                      ? _text
                      : _filterMenu == _text
                          ? _text
                          : "$_filterMenu / $_text")
              : Container(),
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == _onHoverIndex
                    ? Colors.blueGrey.withOpacity(0.2)
                    : MyColors.backgroundColor,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.network(
                        image,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 17),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tür: $category",
                                style: TextStyle(color: MyColors.softWhite),
                              ),
                              Text(
                                "IMDB : $imdb ",
                                style: TextStyle(color: MyColors.softWhite),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
