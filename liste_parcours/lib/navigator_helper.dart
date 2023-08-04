import 'package:flutter/material.dart';
import 'package:liste_parcours/pages/detail_page.dart';

import 'model/place.dart';

class NavigatorHelper {
  toDetail({required BuildContext context, required Place place}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(place: place);
    }));
  }
}
