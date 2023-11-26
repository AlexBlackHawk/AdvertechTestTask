import 'package:http/http.dart' as http;
import 'dart:convert';

class SendingData {
  var url = Uri.parse("https://api.byteplex.info/api/test/contact/");

  Future<int> sendData(String name, String email, String message) async {
    Map<String, String> params = {
      "name": name,
      "email": email,
      "message": message
    };
    var response = await http.post(
      url,
      body: jsonEncode(params),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode;
  }
}