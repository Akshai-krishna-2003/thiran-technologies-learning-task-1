import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/feature/feature5/domain/model/feature5.dart';
import 'package:path/path.dart' as p;

class Feature5Api {
  final String link = "https://restcountries.com/v3.1/all?fields=flags";

  Future<List<Feature5>> getDataForFeat5() async {
    try {
      final uri = Uri.parse(link);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);

        // Use isolate for background parsing
        final receivePort = ReceivePort();
        final isolate = await Isolate.spawn(_parseFeat5Data, {
          'sendPort': receivePort.sendPort,
          'data': data,
          'rootIsolateToken': rootIsolateToken
        });

        // Wait for parsed data
        final result = await receivePort.first;
        isolate.kill();

        final List<Feature5> theData = List<Feature5>.from(result as List);

        print("Total flags fetched: ${theData.length}");
        for (var item in theData.take(5)) {
          print("PNG: ${item.pngUrl}");
          print("SVG: ${item.svgUrl}");
          print("ALT: ${item.description}");
        }

        return theData;
      } else {
        throw Exception("HTTP Error: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error in getDataForFeat5: ${e.toString()}");
    }
  }

  // Isolate entry point for parsing
  static void _parseFeat5Data(Map<String, dynamic> message) async {
    final SendPort sendPort = message['sendPort'];
    final List<dynamic> decodedResponse = message['data'];
    final RootIsolateToken? rit = message['rootIsolateToken'];
    final List<Feature5> feat5Data = [];

    if (rit != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rit);
    }

    try {
      final dir = await getApplicationDocumentsDirectory();

      for (final i in decodedResponse) {
        final flags = i['flags'];
        if (flags == null) continue;

        final pngUrl = flags['png']?.toString() ?? '';
        final svgUrl = flags['svg']?.toString() ?? '';
        final desc = flags['alt']?.toString() ?? 'No description available';

        // Download and store image locally
        String localPath = '';
        if (pngUrl.isNotEmpty) {
          try {
            final download = await http.get(Uri.parse(pngUrl));
            // Create a subfolder called "flags" inside the app documents directory
            final flagsDir = Directory(p.join(dir.path, 'flags'));
            if (!await flagsDir.exists()) {
              await flagsDir.create(recursive: true);
            }

            // Use only the image filename (e.g., "us.png")
            final fileName = p.basename(pngUrl);

            // Build full path inside the flags folder
            final filePath = p.join(flagsDir.path, fileName);

            // Write file
            final file = File(filePath);
            await file.writeAsBytes(download.bodyBytes);

            print("Saved flag to: ${file.path}");
            localPath = file.path;
          } catch (e) {
            print("Image download failed for $pngUrl: $e");
          }
        }

        feat5Data.add(Feature5(
          id: svgUrl,
          pngUrl: pngUrl,
          svgUrl: svgUrl,
          description: desc,
          downloadedPath: localPath,
        ));
      }

      print("Parsed ${feat5Data.length} flags successfully");
      sendPort.send(feat5Data);
    } catch (e, st) {
      print("Parsing error: $e\n$st");
      sendPort.send([]);
    }
  }
}
