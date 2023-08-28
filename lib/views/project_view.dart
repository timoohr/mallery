import 'package:flutter/material.dart';
import 'package:mallery/models/project.dart';
import 'package:mallery/widgets/with_spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({
    super.key,
    required this.project,
  });

  final Project project;

  Widget linkMenu(BuildContext context) {
    return Column(
      children: [
        if (project.driveLink != null) SizedBox(width: 200, child: OutlinedButton(onPressed: () {
          launchUrl(project.driveLink!);
        }, child: const Text("Google Drive"))),
        SizedBox(width: 200, child: OutlinedButton(onPressed: () {
          launchUrl(project.fileLink);
        }, child: const Text("Local"))),
        if (project.etsyLink != null) SizedBox(width: 200, child: OutlinedButton(onPressed: () {
          launchUrl(project.etsyLink!);
        }, child: const Text("Etsy store"))),
      ].withSpacing(height: 10),
    );
  }

  Widget titleBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 42,
          icon: const Icon(Icons.chevron_left_sharp),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(project.title, style: Theme.of(context).textTheme.headlineLarge),
              if (project.id != null) Text(project.id!),
              const SizedBox(height: 16),
              if (project.category != null) Text(project.category!, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget gallery(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 330,
          child: Row(
            children: project.images.take(3).map((e) => Image.file(e)).toList().withSpacing(width: 12),
          ),
        ),
        SizedBox(
          height: 412,
          child: Row(
            children: project.images.skip(3).take(2).map((e) => Image.file(e)).toList().withSpacing(width: 12),
          ),
        ),
      ].withSpacing(height: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            titleBar(context),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                linkMenu(context),
                gallery(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}