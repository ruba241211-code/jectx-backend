import 'package:flutter/material.dart';

class ProjectRoadmapCard extends StatelessWidget {
  final List<String> roadmap;

  const ProjectRoadmapCard({
    super.key,
    required this.roadmap,
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
                  Icons.map,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10),
                Text(
                  "Development Roadmap",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ...roadmap.asMap().entries.map(
              (entry) => ListTile(
                leading: CircleAvatar(
                  radius: 14,
                  child: Text("${entry.key + 1}"),
                ),
                title: Text(entry.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}