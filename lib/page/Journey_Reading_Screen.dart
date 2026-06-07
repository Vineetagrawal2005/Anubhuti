import 'package:anubhuti/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:anubhuti/data/Repository/Journel_Repo.dart';
import 'package:anubhuti/data/model/Journel.dart';

class JourneyReadingScreen extends StatefulWidget {
  const JourneyReadingScreen({super.key});

  @override
  State<JourneyReadingScreen> createState() => _JourneyReadingScreenState();
}

class _JourneyReadingScreenState extends State<JourneyReadingScreen> {
  late JournelRepo _Journel_Repo;
  late Journel? _Journel_Data;
  @override
  void initState() {
    super.initState();
    _call();
  }

  void _call() {
    _Journel_Repo = JournelRepo();
    int index = _Journel_Repo.getIndex();
    _Journel_Data = _Journel_Repo.getData(index);
  }

  late List<String> data_list = _Journel_Data!.suggestedMoods;
  late double size_item = 100;
  late String main_title = _Journel_Data!.title;
  late String desc_text = _Journel_Data!.descrption;
  late Color Border_Color = _Journel_Data!.color;
  late int duration = _Journel_Data!.duration;
  @override
  Widget build(BuildContext context) {
    final remSec = duration;
    final remMinutes = (remSec / 60).floor().toString().padLeft(2, '0');
    final remSeconds = (remSec % 60).toString().padLeft(2, '0');
   
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 20),
            Center(
              child: text_overlayer(context, main_title, 48, Border_Color),
            ),

            SizedBox(height: 20),
            List_Data(data_list, size_item, Border_Color),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  text_overlayer(context, "Descrption", 32, Border_Color),
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
            Expanded(
              child: Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Border_Color),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    desc_text,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
