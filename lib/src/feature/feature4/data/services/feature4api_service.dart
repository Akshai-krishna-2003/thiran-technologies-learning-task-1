import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/feature4/domain/model/feature4.dart';

class Feature4Api {
  final String link = "https://api.openbrewerydb.org/v1/breweries?per_page=200";

  Future<List<Feature4>> getDataForFeat4() async {
    try {
      final uri = Uri.parse(link);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);

        final receivePort = ReceivePort();

        dynamic jklIsolate = await Isolate.spawn(_parseFeat4Data, {
          'sendPort': receivePort.sendPort,
          'data': data,
        });

        // Wait for parsed data
        final result = await receivePort.first;
        final List<Feature4> theData = List<Feature4>.from(result as List);

        // Print parsed results
        for (var item in theData) {
          print("id is: ${item.id}");
          print("name is: ${item.name}");
          print("webUrl is: ${item.webUrl}");
        }
        // print(theData);

        jklIsolate.kill();

        return theData;
      } else {
        throw Exception("HTTP Error: ${res.statusCode}, ${res.body}");
      }
    } catch (e) {
      throw Exception("Error in getDataForFeat4: ${e.toString()}");
    }
  }

  // Isolate entry point
  static void _parseFeat4Data(Map<String, dynamic> message) {
    final SendPort sendPort = message['sendPort'];
    final List<dynamic> decodedResponse = message['data'];

    try {
      print(decodedResponse);
      print(decodedResponse.length);
      final List<Feature4> feat4Data =
          decodedResponse.map((i) => Feature4.fromJson(i)).toList();
      sendPort.send(feat4Data);
    } catch (e) {
      print(e.toString());
      sendPort.send([]);
    }
  }
}
