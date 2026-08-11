import 'package:flutter/material.dart';

class ProjectAIRecommendationCard extends StatelessWidget {
  final List<String> recommendations;

  const ProjectAIRecommendationCard({
    super.key,
    required this.recommendations,
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
                  Icons.auto_awesome,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10),
                Text(
                  "AI Recommendations",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ...recommendations.map(
              (item) => ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                title: Text(item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}