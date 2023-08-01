import 'package:flutter/material.dart';

import 'course.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> courses = [
    "Course 1",
    "Course 2",
    "Course 3",
    "Course 4",
    "Course 5",
    "Course 6",
    "Course 7",
    "Course 8",
    "Course 9",
    "Course 10",
    "Course 11",
    "Course 12",
    "Course 13",
    "Course 14",
  ];

  List<Course> maListeCourses = [];

  List<Widget> itemCourses() {
    List<Widget> items = [];
    courses.forEach((element) {
      final widget = elementToShow(element);
      items.add(widget);
    });
    return items;
  }

  Widget elementToShow(String element) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(element,
              style: TextStyle(
                fontSize: 18.0,
              )),
          Icon(Icons.check),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    courses.forEach((element) {
      maListeCourses.add(Course(element));
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(maListeCourses[index].element),
                leading: Text(index.toString()),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      maListeCourses[index].update();
                    });
                  },
                  icon: Icon((maListeCourses[index].bought)
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                ),
                onTap: () {
                  print('${index + 1} : ${courses[index]}');
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.lightBlue,
              );
            },
            itemCount: maListeCourses.length));
  }
}

// ListView.builder(
// itemCount: courses.length,
// itemBuilder: (BuildContext context, int index) {
// final element = courses[index];
// return elementToShow(element);
// }),

// SingleChildScrollView(
// child: Column(
// children: itemCourses(),
// ),
// ),
