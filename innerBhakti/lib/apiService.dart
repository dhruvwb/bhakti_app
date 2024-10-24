import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  final String _baseUrl = 'http://192.168.1.2:5555/api'; // Corrected base URL

  Future<void> getData() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/getProgramList')); // Corrected endpoint
      if (response.statusCode == 200) {
        print('Data: ${response.body}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
