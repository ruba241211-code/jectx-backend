import 'package:flutter/material.dart';
import 'project_loading_screen.dart';

class ProjectDetailsInputScreen extends StatefulWidget {
  const ProjectDetailsInputScreen({super.key});

  @override
  State<ProjectDetailsInputScreen> createState() =>
      _ProjectDetailsInputScreenState();
}

class _ProjectDetailsInputScreenState
    extends State<ProjectDetailsInputScreen> {

  final TextEditingController projectController =
      TextEditingController();

  String projectType = "Major Project";

  @override
  void dispose() {
    projectController.dispose();
    super.dispose();
  }

  void generateProject() {
    if (projectController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter project title"),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectLoadingScreen(
          projectTitle: projectController.text.trim(),
          projectType: projectType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: projectController,
              decoration: const InputDecoration(
                labelText: "Project Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: projectType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Mini Project",
                  child: Text("Mini Project"),
                ),
                DropdownMenuItem(
                  value: "Major Project",
                  child: Text("Major Project"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  projectType = value!;
                });
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: generateProject,
                icon: const Icon(Icons.auto_awesome),
                label: const Text(
                  "Generate Project Details",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}