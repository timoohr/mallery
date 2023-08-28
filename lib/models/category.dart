import 'package:mallery/models/project.dart';

class Category {
  Category({
    required this.name,
    required this.projects
  });

  final String name;
  final List<Project> projects;
}