/// Automatic sine Pong in Flutter web using the raw layer.

import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_web_ui/ui.dart';

Duration begin;

void beginFrame(Duration timeStamp) {
  final ratio = window.devicePixelRatio, size = window.physicalSize / ratio, paintBounds = Offset.zero & size, recorder = PictureRecorder(), canvas = Canvas(recorder, paintBounds);
  begin ??= timeStamp;
  final t = (timeStamp - begin).inMicroseconds / Duration.microsecondsPerSecond, w = size.width, h = size.height;
  canvas.drawPaint(Paint()..color = const Color(0xffffffff));

  final ph = h / 3, pw = w / 13;
  final yo = (1 + sin(t + pi)) * (h - ph) / 2;
  canvas.drawRect(Rect.fromLTRB(0, yo, pw, yo + ph), Paint()..color = const Color(0xdfd6a1a1));
  final yo2 = (1 + cos(t * 2)) * (h - ph) / 2;
  canvas.drawRect(Rect.fromLTRB(w - pw, yo2, w, yo2 + ph), Paint()..color = const Color(0xdfa1a1d6));

  final bs = w / 17, by = (h - bs) / 2 - sin(t) * h / 3, bx = (w - bs) / 2 + sin(t) * (w - pw * 2 - bs) / 2;
  canvas.drawRect(Rect.fromLTRB(bx, by, bx + bs, by + bs), Paint()..color = const Color(0xee333333));

  window.render((SceneBuilder()
        ..pushTransform(Float64List(16)
          ..[0] = ratio
          ..[5] = ratio
          ..[10] = 1
          ..[15] = 1)
        ..addPicture(Offset.zero, recorder.endRecording())
        ..pop())
      .build());

  window.scheduleFrame();
}

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}