import 'package:flutter/material.dart';
import 'package:geobible/modules/home/utils/home_constants.dart';

class HomeFunctions {
  static imageLoadPerson(String sex, String url) {
    ImageProvider image;
    if (url.isEmpty) {
      image = AssetImage(HomeConstants.PATH_SEX_IMAGE[sex]);
    } else {
      image = Image.network(url).image;
    }
    return image;
  }
}
