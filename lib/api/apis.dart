import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String? apiKey;
  final String? apiUrl;

  ApiService({this.apiKey, this.apiUrl});

  Future<dynamic> getData() async {
    final url =
        Uri.parse('https://text-translator2.p.rapidapi.com/getLanguages');

    final headers = {
      'X-RapidAPI-Key': 'e72c05246bmsh41091605a84bc8ep10028cjsna2db09285406',
      'X-RapidAPI-Host': 'text-translator2.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<dynamic> fetchData(
      String input, String selectedCode1, String selectedCode2) async {
    final url = 'https://text-translator2.p.rapidapi.com/translate';

    final headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Key': 'e72c05246bmsh41091605a84bc8ep10028cjsna2db09285406',
      'X-RapidAPI-Host': 'text-translator2.p.rapidapi.com',
    };

    final data = {
      'source_language': selectedCode1,
      'target_language': selectedCode2,
      'text': input,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final translatedText = result['data']['translatedText'];

        return translatedText;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
