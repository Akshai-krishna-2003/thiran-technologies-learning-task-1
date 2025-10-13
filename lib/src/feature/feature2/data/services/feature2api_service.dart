import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';

class Feature2API {
  final apiUri = "https://24pullrequests.com/users.json?page=100";

  Future<List<Feature2>> getFromApi() async {
    // print("abcd!");
    try {
      final uri = Uri.parse(apiUri);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final recievePort = ReceivePort();

        final feature2Isolate = await Isolate.spawn(
            _parseFeat2Data, [recievePort.sendPort, res.body]);

        final getData = await recievePort.first as List<Feature2>;
        print("This size of feature 2 data is ${getData.length}");

        feature2Isolate.kill();
        return getData;
      } else {
        throw Exception("Failed to fetch data: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error in Feature 2 API: ${e.toString()}");
    }
  }

  static void _parseFeat2Data(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final String responseBody = args[1];

    try {
      final List<dynamic> data = jsonDecode(responseBody);

      final List<Feature2> feat2Data =
          data.map((item) => Feature2.fromJson(item)).toList();

      sendPort.send(feat2Data);
    } catch (e) {
      sendPort.send([]);
    }
  }
}
