import 'package:flutter/material.dart';

import 'package:jectx/features/project_details/models/project_model.dart';

import 'package:jectx/widgets/project_hero_card.dart';
import 'package:jectx/widgets/project_statistics_card.dart';
import 'package:jectx/widgets/project_overview_card.dart';
import 'package:jectx/widgets/project_technology_card.dart';
import 'package:jectx/widgets/project_modules_card.dart';
import 'package:jectx/widgets/project_skills_card.dart';
import 'package:jectx/widgets/project_ai_recommendation_card.dart';
import 'package:jectx/widgets/project_roadmap_card.dart';
import 'package:jectx/widgets/project_quick_actions_card.dart';
import 'package:jectx/widgets/project_resources_card.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ProjectHeroCard(project: project),

            const SizedBox(height: 20),

            ProjectStatisticsCard(project: project),

            const SizedBox(height: 20),

            ProjectOverviewCard(project: project),

            const SizedBox(height: 20),

            ProjectTechnologyCard(project: project),

            const SizedBox(height: 20),

            ProjectModulesCard(project: project),

            const SizedBox(height: 20),

            ProjectSkillsCard(project: project),

            const SizedBox(height: 20),

            ProjectAIRecommendationCard(
              recommendations: project.recommendations,
            ),

            const SizedBox(height: 20),

            ProjectRoadmapCard(
              roadmap: project.roadmap,
            ),

            const SizedBox(height: 20),

            const ProjectQuickActionsCard(),

            const SizedBox(height: 20),

            const ProjectResourcesCard(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}