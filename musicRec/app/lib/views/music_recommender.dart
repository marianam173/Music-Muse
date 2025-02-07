import 'dart:convert';

import 'package:http/http.dart';
import 'package:app/models/music.dart';

class MusicRecommender {
  static Future<List<Music>> search(String artist, List<String> genres) async {
    final response = await post(Uri.parse('http://127.0.0.1:8000/recommend'),
        headers: {
          'Content-Type': 'application/json'
        },
        body:
            jsonEncode({"artist_name": artist, "genres": genres, "attrs": {}}));
    List<dynamic> data = jsonDecode(response.body)['recommendations'];
    List<Music> result = data.map((e) => Music.fromJson(e)).toList();
    return result;
  }
}
