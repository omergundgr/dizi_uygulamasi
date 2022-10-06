import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wistv/models/season_model.dart';

final _firestoreSeries = FirebaseFirestore.instance.collection("series");
final _firestoreEditorsChoice =
    FirebaseFirestore.instance.collection("editorsChoice");

Future<List<SeasonModel>> fetchSeries(
    {required bool isSeries,
    required String clickCategory,
    bool isSearch = false}) async {
  late QuerySnapshot<Map<String, dynamic>> docList;
  if (isSearch) {
    docList = await _firestoreSeries
        .where("searchList", arrayContains: clickCategory.toLowerCase())
        .limit(8)
        .get();
  } else if (clickCategory == "Diziler" || clickCategory == "Filmler") {
    docList = await _firestoreSeries
        .where("series", isEqualTo: isSeries)
        .orderBy("imdb", descending: true)
        .limit(8)
        .get();
  } else if (clickCategory == "Anime" || clickCategory == "Çizgi Film") {
    docList = await _firestoreSeries
        .where("category", arrayContains: clickCategory)
        .limit(8)
        .get();
  } else {
    docList = await _firestoreSeries
        .where("series", isEqualTo: isSeries)
        .where("category", arrayContains: clickCategory)
        //.orderBy("imdb", descending: true)
        .limit(8)
        .get();
  }
  return docList.docs.map((e) => SeasonModel(startValue: e.data())).toList();
}

Future<List<SeasonModel>> fetchEditorsChoice() async {
  var docList = await _firestoreEditorsChoice.get();
  List tokenList = docList.docs.first.data()["list"];
  List<SeasonModel> choiceModelList = [];
  for (String token in tokenList) {
    var seasonData =
        await _firestoreSeries.doc(token).get().then((value) => value.data());
    choiceModelList.add(SeasonModel(startValue: seasonData ?? {}));
  }
  return choiceModelList;
}
