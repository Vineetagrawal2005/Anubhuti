import 'package:flutter/material.dart';

Stack text_overlayer(BuildContext context, String data, double fontSize,Color color) {
  return Stack(
    children: [
      Text(
        data,
        style: TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.none,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4.0
            ..color = color,
        ),
      ),
      Text(
        data,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.none,
        ),
      ),
    ],
  );
}

SizedBox List_Data(
  List<String> dataList,
  double sizeItem,
  Color borderColor,
) {
  return SizedBox(
    height: 32,
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              dataList[index],
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        );
      },
      itemCount: dataList.length,
      itemExtent: sizeItem,
      scrollDirection: Axis.horizontal,
    ),
  );
}
