import 'package:anubhuti/core/Provider/Theme_Provider.dart';
import 'package:anubhuti/data/Repository/Journel_Repo.dart';
import 'package:anubhuti/data/model/Journel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late JournelRepo _Journel_Repo;
  late List<Journel> _Journel_List;
  @override
  void initState() {
    super.initState();
    _call();
  }

  void _call() {
    _Journel_Repo = JournelRepo();
    _Journel_List =  _Journel_Repo.getAllData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh the list when returning to this screen
    setState(() {
      _Journel_List = _Journel_Repo.getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          itemCount: _Journel_List.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _Journel_Repo.setIndex(index);
                Navigator.pushNamed(context, '/Journey_Reading_Screen');
              },
              child: Container(
                height: 250,
                width: 250,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _Journel_List[index].color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<ThemeProvider>(
                        builder: (context, _, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                _Journel_List[index].title,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await _Journel_Repo.deleteData(index);
                                  setState(() {
                                    _Journel_List = _Journel_Repo.getAllData();
                                  });
                                },
                                child: Icon(Icons.delete),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
          ),
        ),
      ),
    );
  }
}
