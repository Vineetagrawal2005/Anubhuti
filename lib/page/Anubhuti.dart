import 'package:anubhuti/core/Provider/Theme_Provider.dart';
import 'package:anubhuti/page/History_Screen.dart';
import 'package:anubhuti/page/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnubhutiScreen extends StatefulWidget {
  const AnubhutiScreen({super.key});

  @override
  State<AnubhutiScreen> createState() => _AnubhutiScreenState();
}

class _AnubhutiScreenState extends State<AnubhutiScreen> {
  int My_Index = 0;
  var Data = [
    [HomeScreen(), "Home", Icons.home],
    [HistoryScreen(), "History", Icons.history],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Text_appbar(context, Data[My_Index][1] as String),
      body: Data[My_Index][0] as StatefulWidget,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomNavigationBar(
            currentIndex: My_Index,
            backgroundColor: Theme.of(context).colorScheme.primary,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            selectedLabelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            unselectedLabelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),

            onTap: (index) {
              setState(() {
                My_Index = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomBar(
                Data[0][1] as String,
                Data[0][2] as IconData,
                My_Index,
                0,
              ),
              BottomBar(
                Data[1][1] as String,
                Data[1][2] as IconData,
                My_Index,
                1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem BottomBar(
    String data,
    IconData iconData,
    int curIndex,
    int myIndex,
  ) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: curIndex == myIndex
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
        ),
        child: Icon(
          iconData,
          color: curIndex == myIndex
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
      label: data,
    );
  }
}

AppBar Text_appbar(BuildContext context, String data) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    centerTitle: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    actions: [
      Consumer<ThemeProvider>(
        builder: (_, provider, _) {
          return Container(
            margin: EdgeInsets.all(4),
            child: Switch.adaptive(
              value: provider.getValue(),
              activeColor: Theme.of(context).colorScheme.primary,
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              inactiveThumbColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.secondary,

              onChanged: (value) {
                provider.UpdateTheme(value: value);
              },
            ),
          );
        },
      ),
    ],
    title: Text(
      data,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 32,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
