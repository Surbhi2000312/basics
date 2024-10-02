import 'dart:convert';
import 'package:http/http.dart' as http;





// class ApiService {
//   Future<void> getUsers() async {
//     var url = Uri.parse('http://192.168.1.12:8080/users');
//     var request = http.Request('GET', url);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       String responseBody = await response.stream.bytesToString();
//       print(jsonDecode(responseBody)); // parse JSON response
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }
class ApiService {
  Future<List<dynamic>> getUsers() async {
    var url = Uri.parse('http://192.168.1.12:8080/users');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody); // Return the parsed JSON as a list
    } else {
      print(response.reasonPhrase);
      return []; // Return an empty list in case of an error
    }
  }
}
