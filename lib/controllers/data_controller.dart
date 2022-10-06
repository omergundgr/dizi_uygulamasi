import 'package:get/get.dart';

import '../funcs/fetch_series.dart';
import '../models/season_model.dart';

class DataController extends GetxController {
  Rxn<List<SeasonModel>> seriesData = Rxn<List<SeasonModel>>();
  Rxn<List<SeasonModel>> choiceData = Rxn<List<SeasonModel>>();

  Future addToSeriesData(
      {required Map data,
      required bool isSeries,
      required String clickCategory,
      required bool isMenu}) async {
    print(data);
    print(isSeries);
    print(clickCategory);
    print(isMenu);
    if (data["text"] == data["filterMenu"] || isMenu) data.remove("filterMenu");
    bool isSearch = false;
    if (data['filterMenu'] == "Ara") {
      seriesData.value = [];
      isSearch = true;
    } else if (data['filterMenu'] == null) {
      seriesData.value = [];
      clickCategory = data['text'];
    }
    var newDataList = await fetchSeries(
        isSeries: isSeries, clickCategory: clickCategory, isSearch: isSearch);
    print(newDataList);
    if (seriesData.value == null || newDataList.isEmpty) {
      seriesData.value = [];
    } else {
      seriesData.value!.addAll(newDataList);
    }
    seriesData.refresh();
  }

  Future getChoiceData() async {
    choiceData.value ??= [];
    choiceData.value?.addAll(await fetchEditorsChoice());
    choiceData.refresh();
  }
}
