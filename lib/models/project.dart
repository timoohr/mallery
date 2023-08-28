import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:collection/collection.dart';
import 'package:yaml/yaml.dart' as yaml;

class Project {
  const Project({
    this.id,
    required this.title,
    this.category,
    this.cover,
    this.images = const [],
    this.driveLink,
    required this.fileLink,
    this.etsyLink,
  });

  final String? id;
  final String title;
  final String? category;
  final File? cover;
  final List<File> images;
  final Uri? driveLink;
  final Uri fileLink;
  final Uri? etsyLink;

  static Future<Project> open(Directory dir) async {
    final files = (await dir.list().toList()).whereType<File>();

    final fileLink = Uri.parse('file://${dir.absolute.path}');

    String? id;
    String title;
    String? category;
    Uri? driveLink;
    Uri? etsyLink;

    { // Load meta info
      final file = files.firstWhereOrNull((element) => p.basename(element.path) == 'meta.yaml');

      if (file != null) {
        final meta = await yaml.loadYaml(await file.readAsString());
        id = meta['id'];
        title = meta['title'];
        category = meta['category'];
        driveLink = Uri.parse(meta['drive']);
        etsyLink = Uri.parse(meta['etsy']);
      } else {
        title = p.basename(dir.path);
      }
    }

    File? cover;
    { // Load cover image
      cover = files.firstWhereOrNull((element) => p.basename(element.path).startsWith("cover"));
    }

    List<File> images = [];
    { // Load Images
      images = files
          .where((element) => p.basename(element.path).startsWith("gal"))
          .sortedBy((element) => p.basename(element.path))
          .toList();
    }

    return Project(
      id: id,
      title: title,
      category: category,
      cover: cover,
      images: images,
      driveLink: driveLink,
      fileLink: fileLink,
      etsyLink: etsyLink,
    );
  }
}