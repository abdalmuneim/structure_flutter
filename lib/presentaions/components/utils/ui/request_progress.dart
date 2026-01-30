import 'dart:async';

class RequestProgress {
  static StreamController<String> requestProgress =
      StreamController.broadcast();

  static updateProgress(double progress) {
    print("progress${(progress * 100).toStringAsFixed(2)}");
    requestProgress.add((progress * 100).toInt().toString());
  }
}
