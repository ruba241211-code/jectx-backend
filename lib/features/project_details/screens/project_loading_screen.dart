import 'package:flutter/material.dart';

import 'package:jectx/features/project_details/models/project_model.dart';
import 'package:jectx/features/project_details/screens/project_details_screen.dart';

import 'package:jectx/services/project_details_service.dart';

class ProjectLoadingScreen extends StatefulWidget {
  final String projectTitle;
  final String projectType;

  const ProjectLoadingScreen({
    super.key,
    required this.projectTitle,
    required this.projectType,
  });

  @override
  State<ProjectLoadingScreen> createState() =>
      _ProjectLoadingScreenState();
}

class _ProjectLoadingScreenState
    extends State<ProjectLoadingScreen> {

  @override
  void initState() {
    super.initState();
    loadProject();
  }

  Future<void> loadProject() async {
    try {

      final service = ProjectDetailsService();

      final json = await service.generateProjectDetails(
        title: widget.projectTitle,
        projectType: widget.projectType,
      );

      final project = ProjectModel.fromJson(json);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectDetailsScreen(
            project: project,
          ),
        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Center(

          child: Padding(

            padding: const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: const [

                Icon(
                  Icons.auto_awesome,
                  size: 90,
                  color: Colors.deepPurple,
                ),

                SizedBox(height: 30),

                Text(
                  "JECTX AI",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Generating your project details...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                SizedBox(height: 40),

                CircularProgressIndicator(),

              ],

            ),

          ),

        ),

      ),

    );

  }

}