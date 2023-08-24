import 'package:flutter/material.dart';

class MapAppBarView extends PreferredSize {
  final BuildContext context;
  final Function() menuPressed;
  final Function() followPosition;
  final Function() zoomIn;
  final Function() zoomOut;
  final Icon followIcon;

  MapAppBarView(
      {required this.context,
      required this.menuPressed,
      required this.followPosition,
      required this.zoomIn,
      required this.zoomOut,
      required this.followIcon})
      : super(
            preferredSize: Size.fromHeight(75),
            child: Container(
              color: Colors.teal,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: menuPressed,
                            icon: const Icon(Icons.menu),
                            color: Colors.white,
                          ),
                          const Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: followPosition,
                                  icon: followIcon,
                                  color: Colors.white,
                                ),
                                IconButton(
                                  onPressed: zoomIn,
                                  icon: const Icon(Icons.zoom_in),
                                  color: Colors.white,
                                ),
                                IconButton(
                                  onPressed: zoomOut,
                                  icon: const Icon(Icons.zoom_out),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
}
