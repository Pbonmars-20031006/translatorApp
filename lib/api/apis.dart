import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey;
  final String apiUrl;

  ApiService({required this.apiKey, required this.apiUrl});

  Future<dynamic> getData(String path) async {
    final String url = apiUrl;
    final Map<String, String> headers = {
      'Accept-Encoding': 'application/gzip',
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
