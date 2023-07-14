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

  Expanded buildBtnSound(double size, int index, Color color) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: size),
        child: TextButton(
          onPressed: () {
            playSound(index);
          },
          child: Text(''),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double mysize = MediaQuery.of(context).size.width / 2;
    double addSize = mysize / 7;

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
              buildBtnSound(mysize - addSize * 1, 1, Colors.red),
              buildBtnSound(mysize - addSize * 2, 2, Colors.orange),
              buildBtnSound(mysize - addSize * 3, 3, Colors.yellow),
              buildBtnSound(mysize - addSize * 4, 4, Colors.greenAccent),
              buildBtnSound(mysize - addSize * 5, 5, Colors.green),
              buildBtnSound(mysize - addSize * 6, 6, Colors.blue),
              buildBtnSound(mysize - addSize * 7, 7, Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
