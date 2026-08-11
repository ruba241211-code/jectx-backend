import 'package:flutter/material.dart';
import 'package:jectx/features/project_details/models/project_model.dart';

class ProjectSkillsCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectSkillsCard({
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
                  Icons.school,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10),
                Text(
                  "Skills Required",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: project.skills.map((skill) {
                return Chip(
                  avatar: const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.green,
                  ),
                  label: Text(skill),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}