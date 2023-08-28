import 'package:flutter/material.dart';
import 'package:mallery/models/category.dart';
import 'package:mallery/models/manager.dart';
import 'package:mallery/models/project.dart';
import 'package:mallery/views/project_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<Manager>();

    final List<Project> projects;
    if (_selectedCategory != null) {
      projects = _selectedCategory!.projects;
    } else {
      projects = manager.projects;
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisSize:MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: manager.categories.map((e) => TextButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedCategory == e) {
                        _selectedCategory = null;
                      } else {
                        _selectedCategory = e;
                      }
                    });
                  },

                  child: Text('${e.projects.length} / ${e.name}'),
                )).toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.extent(
              padding: const EdgeInsets.all(100),
              maxCrossAxisExtent: 320,
              childAspectRatio: 1/1.5,
              crossAxisSpacing: 34,
              mainAxisSpacing: 100,
              children: projects.map((project) {
                return _ProjectWidget(project: project);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectWidget extends StatelessWidget {
  const _ProjectWidget({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ProjectView(project: project),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: project.cover == null ? Theme.of(context).primaryColor : null,
          image: project.cover != null ? DecorationImage(
            image: FileImage(project.cover!),
            fit: BoxFit.cover,
          ) : null,
        ),
      ),
    );
  }
}