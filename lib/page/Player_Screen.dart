import 'dart:async';
import 'package:anubhuti/data/Repository/Journel_Repo.dart';
import 'package:anubhuti/data/model/Journel.dart';
import 'package:anubhuti/core/Provider/Ambience_provider.dart';
import 'package:anubhuti/data/Repository/Ambidence_repo.dart';
import 'package:anubhuti/data/Repository/Play_Repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anubhuti/widget/widget.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  double size_item = 100.0;

  late TextEditingController descrpControl;

  late JournelRepo _Journel_Repo;
  late Journel _Journel_Data;
  String descrp_String = '';
  final PlayRepo _player = PlayRepo();
  bool is_play = false;
  bool is_ready = false;
  int _seconds = 0;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    descrpControl = TextEditingController();
    _call();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
    setState(() {});
    if (is_ready) {
      is_ready = false;
      is_play = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ambienceId = Provider.of<AmbienceProvider>(
        context,
        listen: false,
      ).currentAmbience;
      if (ambienceId == null) {
        return;
      }
      final amb = await AmbienceRepo.loadById(ambienceId.id);
      if (amb == null) {
        return;
      }

      final loaded = await _player.initializeAudio(
        "assets/audio/${amb.audioFile.toString()}",
      );
      if (!loaded) {
        return;
      }
      _player.play();
      is_ready = true;
      is_play = true;
      setState(() {});
    });
  }
  void _call() {
    _Journel_Repo = JournelRepo();
  }
  @override
  void dispose() {
    _player.PlayerDispose();
     descrpControl.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remSec = _seconds;
    final remMinutes = (remSec / 60).floor().toString().padLeft(2, '0');
    final remSeconds = (remSec % 60).toString().padLeft(2, '0');
    final borderColor = Theme.of(context).colorScheme.primary;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AmbienceProvider>(
              builder: (context, provider, _) {
                final currentAmbience = provider.currentAmbience;
                if (currentAmbience == null) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Loading...'),
                    ),
                  );
                }
            
                List<String> dataList = currentAmbience.suggestedMoods.toList();
                Color borderColor = Theme.of(context).colorScheme.secondary;
            
                return Hero(
                  tag: "Ambience_Card",
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Text(
                                  currentAmbience.title,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                    fontSize: 32,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              List_Data(dataList, size_item, borderColor),
                              
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            setState(() {
                              is_play = !is_play;
                              if (is_play) {
                                _player.play();
                              } else {
                                _player.pause();
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          backgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          backgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          is_play
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 48,
                                        ),
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      SizedBox(width: 8)
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: Consumer<AmbienceProvider>(
                  builder: (_, provider, _) {
                    final currentAmbience = provider.currentAmbience;
                    if (currentAmbience == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    String mainTitle = currentAmbience.title;
                    List<String> dataList = currentAmbience.suggestedMoods
                        .toList();
                    return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  text_overlayer(context, "Descrption", 32, borderColor),
                  Text(
                                '$remMinutes:$remSeconds',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                ],
              ),
            ),
                SizedBox(height: 10),
                Container(
                  height: 360,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (value) => descrp_String = value,
                    controller: descrpControl,
                    maxLines: null,
                    minLines: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Button("Save", () async {
                      _player.StopAndComplete();
                      _timer.cancel();
                      _Journel_Data = Journel(
                        id: provider.currentAmbience!.id,
                        title: mainTitle,
                        color: borderColor,
                        suggestedMoods: dataList,
                        descrption: descrpControl.text.isEmpty
                            ? descrp_String
                            : descrpControl.text, duration: _seconds,
                      );
                      await _Journel_Repo.addData(_Journel_Data);
                      Navigator.pushReplacementNamed(
                        context,
                        "/Anubhuti_Screen",
                      );
                    }),
                    SizedBox(width: 20),
                    Button("Cancel", () {
                      _player.StopAndComplete();
                      _timer.cancel();
                      Navigator.pushReplacementNamed(
                        context,
                        "/Anubhuti_Screen",
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      
            ))
          ],
        ),
      ),
    );
  }
  ElevatedButton Button(String data, Function() OnPressed) {
    return ElevatedButton(
      onPressed: OnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: Text(
        data,
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
    );
  }
}
