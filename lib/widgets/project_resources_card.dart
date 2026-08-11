import 'package:flutter/material.dart';

class ProjectResourcesCard extends StatelessWidget {
  const ProjectResourcesCard({super.key});

  @override
  Widget build(BuildContext context) {

    final resources = [
      "Flutter Documentation",
      "FastAPI Documentation",
      "PostgreSQL Guide",
      "GitHub Sample Project",
      "YouTube Tutorial Playlist",
    ];

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
                Icon(Icons.menu_book, color: Colors.deepPurple),
                SizedBox(width: 10),
                Text(
                  "Project Resources",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ...resources.map(
              (item) => ListTile(
                leading: const Icon(Icons.link),
                title: Text(item),
                trailing: const Icon(Icons.open_in_new),
              ),
            ),

          ],
        ),
      ),
    );
  }
}