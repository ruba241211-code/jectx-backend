import 'package:flutter/material.dart';
import 'package:jectx/features/project_details/models/project_model.dart';

class ProjectHeroCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectHeroCard({
    super.key,
    required this.project,
  });

  String getMotivation(int progress) {
    if (progress == 0) {
      return "🚀 Ready to begin!\nEvery great project starts with one idea.";
    } else if (progress < 25) {
      return "🌱 Great start!\nKeep building your project.";
    } else if (progress < 50) {
      return "💪 Nice work!\nYou're gaining momentum.";
    } else if (progress < 75) {
      return "🔥 You're on fire!\nKeep going.";
    } else if (progress < 100) {
      return "🎯 Almost there!\nFinish strong.";
    } else {
      return "🏆 Congratulations!\nProject Completed.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff4F46E5),
            Color(0xff7C3AED),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Icon(
            Icons.auto_awesome,
            color: Colors.white,
            size: 35,
          ),

          const SizedBox(height: 15),

          Text(
            project.projectName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "${project.domain} • ${project.projectType}",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 30),

          Row(
            children: [

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: project.progress / 100,
                    minHeight: 12,
                    backgroundColor: Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              Text(
                "${project.progress}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    getMotivation(project.progress),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}