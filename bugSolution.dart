```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Process jsonData
    } else {
      throw HttpException('HTTP error! Status code: ${response.statusCode}', response.statusCode);
    }
  } on SocketException catch (e) {
    print('Network error: $e');
  } on FormatException catch (e) {
    print('JSON decoding error: $e');
  } on HttpException catch (e) {
    print('HTTP error: ${e.message} (Status code: ${e.statusCode})');
  } catch (e) {
    print('Unhandled error: $e');
  }
}

class HttpException implements Exception {
  final String message;
  final int? statusCode;
  HttpException(this.message, this.statusCode);
}
```