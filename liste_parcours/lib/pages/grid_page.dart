import 'package:flutter/material.dart';

import '../model/data_source.dart';

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    final datas = DataSource().allPlaces();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Grid List'),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (ctx, i) {
          final place = datas[i];
          return InkWell(
            child: Card(
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                height: size.height * 0.75,
                child: Column(
                  children: [
                    Expanded(
                        child: Image.asset(place.getFolderPath(),
                            fit: BoxFit.cover)),
                    Text(
                      place.name,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              //Naviguer
              //NavigatorHelper().toDetail(context: context, place: place);
            },
          );
        },
        itemCount: datas.length,
      ),
    );
  }
}
