import 'package:flutter/material.dart';
import 'package:jectx/features/project_details/models/project_model.dart';

class ProjectModulesCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectModulesCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [
                Icon(
                  Icons.view_module,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10),
                Text(
                  "Project Modules",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ...project.modules.map(
              (module) => Card(
                elevation: 0,
                color: Colors.grey.shade100,
                child: ListTile(
                  leading: const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.deepPurple,
                  ),
                  title: Text(module),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}