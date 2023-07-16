import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:xylophone/components/gradient_button.dart';

void main() {
  runApp(XyloApp());
}

class XyloApp extends StatelessWidget {
  const XyloApp({super.key});

  Future<void> playSound(int index) async {
    final player = AudioPlayer();
    await player.play(AssetSource('note$index.wav'));
  }

  static const List<Color> xyloColors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.greenAccent,
    Colors.green,
    Colors.blue,
    Colors.purple
  ];

  Expanded buildBtnSound(BuildContext context, int index, Color color) {
    double mysize = MediaQuery.of(context).size.width / 2;
    double addSize = mysize / 7;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: mysize - addSize * index),
        child: TextButton(
          onPressed: () {
            playSound(index);
          },
          child: Text(''),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(xyloColors[index - 1]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // for (var i = 0; i < 3; i++) ...[
              //   buildBtnSound(mysize - addSize * 1, 1, Colors.red),
              // ],
              buildBtnSound(context, 1, Colors.red),
              buildBtnSound(context, 2, Colors.orange),
              buildBtnSound(context, 3, Colors.yellow),
              buildBtnSound(context, 4, Colors.greenAccent),
              buildBtnSound(context, 5, Colors.green),
              buildBtnSound(context, 6, Colors.blue),
              buildBtnSound(context, 7, Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
