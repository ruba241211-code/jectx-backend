import 'package:flutter/material.dart';
import 'package:jectx/features/project_details/models/project_model.dart';

class ProjectStatisticsCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectStatisticsCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.9,
      children: [

        _StatCard(
          icon: Icons.star,
          title: "Difficulty",
          value: project.difficulty,
        ),

        _StatCard(
          icon: Icons.schedule,
          title: "Duration",
          value: project.estimatedDuration,
        ),

        _StatCard(
          icon: Icons.group,
          title: "Team Size",
          value: project.teamSize,
        ),

        _StatCard(
          icon: Icons.folder_copy,
          title: "Project Type",
          value: project.projectType,
        ),

      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
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
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Icon(
              icon,
              size: 32,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

          ],
        ),
      ),
    );
  }
}