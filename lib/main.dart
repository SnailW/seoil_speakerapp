import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  void _showPopup(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('알림'),
          content: Text('연결추가 테스트입니다'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            leading: Icon(CupertinoIcons.sparkles),
            largeTitle: Text('Connect'),
            trailing: GestureDetector(
              onTap: () => _showPopup(context),
              child: Icon(CupertinoIcons.add_circled),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CupertinoListSection(
                  children: [
                    CupertinoListTile(
                      title: const Text('test 1'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => DetailPage(index: 1),
                          ),
                        );
                      },
                    ),
                    CupertinoListTile(
                      title: const Text('test 2'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => DetailPage(index: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class DetailPage extends StatefulWidget {
  final int index;

  DetailPage({required this.index});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color _currentColor = CupertinoColors.systemBlue;
  double _brightness = 0.5;

  void _showColorPicker() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('색상 선택'),
          content: Material(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('test ${widget.index}'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/test_img_1.png',
              width: 150,
              height: 150,
            ),
            Text('\n\n'),
            CupertinoButton(
              child: Text('색상 선택'),
              color: _currentColor,
              onPressed: _showColorPicker,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('\n\n밝기 조절'),
            ),
            CupertinoSlider(
              value: _brightness,
              onChanged: (double value) {
                setState(() {
                  _brightness = value;
                });
              },
              min: 0.0,
              max: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}