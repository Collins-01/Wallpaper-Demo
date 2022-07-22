import 'dart:developer';
import 'package:wallpaper/wallpaper.dart';

class WallPaperService {
  // Stream<String>? _downloadProgress;
  // Stream<String>? get downloadProgress => _downloadProgress;
  setWallPaper({
    double height = 0,
    double width = 0,
  }) async {
    try {
      var res = await Wallpaper.bothScreen(
        height: height,
        width: width,
      );
      log("Response : $res");
    } catch (e) {
      log("[WallPaperService]| [setWallPaper] ::::  $e");
    }
  }

  Stream<String> downloadImage(String url) async* {
    try {
      //
      var response = Wallpaper.imageDownloadProgress(
        url,
        location: DownloadLocation.TEMPORARY_DIRECTORY,
        // imageName: imageName,
      );
      yield* response;
    } catch (e) {
      //
      print("Error downloading Picture was | $e");
      return;
    }
  }
}

String get imageName {
  final date = DateTime.now();
  final day = date.day.toString();
  final month = date.month.toString();
  final year = date.year.toString();
  return day + "-" + month + "-" + year;
}
