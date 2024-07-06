import 'package:flutter/material.dart';
import '../themes/colours.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxWidget(),
            BoxWidget(),
            BoxWidget(),
            BoxWidget(),
            BoxWidget(),
            SizedBox(height: 10),
            Text(
              'Akash',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.red : Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final boxColor = theme.brightness == Brightness.dark
        ? AppColors.darkBoxColor
        : AppColors.lightBoxColor;

    return Container(
      margin: EdgeInsets.all(8.0),
      width: 100,
      height: 100,
      color: boxColor,
    );
  }
}
