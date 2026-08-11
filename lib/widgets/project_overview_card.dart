import 'package:flutter/material.dart';
import 'package:jectx/features/project_details/models/project_model.dart';

class ProjectOverviewCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectOverviewCard({
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
                  Icons.description_outlined,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10),
                Text(
                  "Project Overview",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Text(
              project.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),

          ],
        ),
      ),
    );
  }
}