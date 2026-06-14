import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:game_app/feature/team_vs_team/data/model/media_model.dart';

class MediaRepository {
  MediaData? _mediaData;
  List<dynamic> _luckyCards = [];
  final Random _random = Random();

  Future<void> loadData() async {
    final String response = await rootBundle.loadString('assets/json/media_data.json');
    final data = await json.decode(response);
    _mediaData = MediaData.fromJson(data);

    try {
      final String luckyResponse = await rootBundle.loadString('assets/json/lucky_card.json');
      _luckyCards = await json.decode(luckyResponse);
    } catch (e) {
      _luckyCards = [];
    }
  }

  String getRandomLuckyCard() {
    if (_luckyCards.isEmpty) return "لا يوجد كارت حظ";
    final card = _luckyCards[_random.nextInt(_luckyCards.length)];
    return card['name'] ?? "لا يوجد كارت حظ";
  }

  MediaItem getRandomMovie() {
    if (_mediaData == null || _mediaData!.movies.isEmpty) throw Exception("Data not loaded");
    return _mediaData!.movies[_random.nextInt(_mediaData!.movies.length)];
  }

  MediaItem getRandomSeries() {
    if (_mediaData == null || _mediaData!.series.isEmpty) throw Exception("Data not loaded");
    return _mediaData!.series[_random.nextInt(_mediaData!.series.length)];
  }

  MediaItem getRandomPlay() {
    if (_mediaData == null || _mediaData!.plays.isEmpty) throw Exception("Data not loaded");
    return _mediaData!.plays[_random.nextInt(_mediaData!.plays.length)];
  }
}
