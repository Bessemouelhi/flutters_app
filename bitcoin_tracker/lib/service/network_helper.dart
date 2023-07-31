import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final Uri uri;

  NetworkHelper(this.uri);

  Future getData() async {
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      return jsonDecode(data);
    }

    print(response.statusCode);
  }
}
