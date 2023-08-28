import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mallery/models/category.dart';
import 'package:mallery/models/project.dart';
import 'package:path/path.dart' as p;

class Manager with ChangeNotifier {
  Manager({
    required String path,
  }) {
    final dir = Directory(path);
    _scanDir(dir);
    _subscription = Directory(path).watch(recursive: true).listen((event) {
      _scanDir(dir);
    });
  }

  StreamSubscription<FileSystemEvent>? _subscription;

  List<Project> projects = [];
  List<Category> categories = [];

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future _scanDir(Directory dir) async {
    final projectDirs = (await dir.list().toList())
        .whereType<Directory>()
        .sortedBy((element) => p.basename(element.path));

    projects = [];

    for (var projectDir in projectDirs) {
      projects.add(await Project.open(projectDir));
    }

    categories = [];
    projects.where((e) => e.category != null).groupListsBy((e) => e.category!).forEach((key, value) {
      categories.add(Category(name: key, projects: value));
    });

    notifyListeners();
  }
}
