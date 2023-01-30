import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:my_movies/data.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class MyProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Data> data = [];
  PickedFile? imageFile = null;
  ImagePicker imagePicker = ImagePicker();
  String centerText = '';
  bool firstOpen = false;

  void isCenterText() {
    if (data.isEmpty) {
      centerText = 'No movies was added';
    } else {
      centerText = '';
    }
    notifyListeners();
  }



  void initial() async {
    SharedPreferences prefs = await _prefs;
    List<String> names = prefs.getStringList('names') ?? [];
    List<String> directors = prefs.getStringList('directors') ?? [];
    List<String> images = prefs.getStringList('images') ?? [];
    List<String> dates = prefs.getStringList('dates') ?? [];

    prefs.setBool('isOpened', true);

    for (int i = 0; i < names.length; i++) {
      data.add(Data(names[i], directors[i], images[i], dates[i]));
    }

    isCenterText();
    notifyListeners();
  }

  MyProvider() {
    initial();
  }

  void addData(Data d) async {
    SharedPreferences prefs = await _prefs;
    List<String> names = prefs.getStringList('names') ?? [];
    List<String> directors = prefs.getStringList('directors') ?? [];
    List<String> images = prefs.getStringList('images') ?? [];
    List<String> dates = prefs.getStringList('dates') ?? [];

    names.add(d.name);
    directors.add(d.director);
    images.add(d.image);
    dates.add(d.date);

    prefs.setStringList('names', names);
    prefs.setStringList('directors', directors);
    prefs.setStringList('images', images);
    prefs.setStringList('dates', dates);
    data.add(d);
    isCenterText();
    notifyListeners();
  }

  void removeData(Data d) async {
    SharedPreferences prefs = await _prefs;
    List<String> names = prefs.getStringList('names') ?? [];
    List<String> directors = prefs.getStringList('directors') ?? [];
    List<String> images = prefs.getStringList('images') ?? [];
    List<String> dates = prefs.getStringList('dates') ?? [];

    names.remove(d.name);
    directors.remove(d.director);
    images.remove(d.image);
    dates.remove(d.date);

    prefs.setStringList('names', names);
    prefs.setStringList('directors', directors);
    prefs.setStringList('images', images);
    prefs.setStringList('dates', dates);

    data.remove(d);

    isCenterText();
    notifyListeners();
  }

  Future<void> getPicture() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageFile = pickedFile;
    notifyListeners();
  }
}


