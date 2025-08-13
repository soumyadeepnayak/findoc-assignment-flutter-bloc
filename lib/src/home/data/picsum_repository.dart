import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/picsum_image.dart';

class PicsumRepository {
  final http.Client _client;
  PicsumRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<List<PicsumImage>> fetchImages({int limit = 10}) async {
    final Uri url = Uri.parse('https://picsum.photos/v2/list?page=1&limit=$limit');
    final http.Response response = await _client.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((dynamic e) => PicsumImage.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to load images');
  }
}

