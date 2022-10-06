class SeasonModel {
  late String title;
  late String description;
  late List category;
  late String imdb;
  late String image;
  late String trailer;
  late Map season;
  late int seasonNumber;
  late bool series;
  late String html;

  SeasonModel({required Map<String, dynamic> startValue}) {
    title = startValue['title'];
    description = startValue['description'];
    startValue['category'].runtimeType == String
        ? category = [startValue['category']]
        : category = startValue['category'];
    imdb = startValue['imdb'];
    image = startValue['image'];
    trailer = startValue['trailer'];
    season = startValue['season'];
    seasonNumber = season.keys.length;
    series = startValue['series'];
    html = startValue['html'];
  }

  getChapterNumber<int>({required int seasonNumber}) {
    if (season.containsKey(seasonNumber.toString())) {
      return season[seasonNumber.toString()]["chapters"].length;
    } else {
      return 0;
    }
  }
}
