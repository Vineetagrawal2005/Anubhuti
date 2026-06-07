import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayRepo {
  final AudioPlayer _audioplayer = AudioPlayer();
  Future<bool> initializeAudio(String FilePath) async {
    try {
      await _audioplayer.setAsset(FilePath);
      await _audioplayer.setLoopMode(LoopMode.one);
      return true;
    } catch (e) {
      debugPrint("Error initializing file path: $e");
      return false;
    }
  }

  void play() {
    _audioplayer.play();
  }

  void pause() {
    _audioplayer.pause();
  }

  Future<void> StopAndComplete() async {
    await _audioplayer.stop();
    await _audioplayer.seek(Duration.zero);
  }

  void PlayerDispose() {
    _audioplayer.dispose();
  }
}
