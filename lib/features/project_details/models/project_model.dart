class ProjectModel {
  final String projectName;
  final String domain;
  final String projectType;
  final String difficulty;
  final int progress;
  final String estimatedDuration;
  final String teamSize;
  final String description;

  final List<String> technologies;
  final List<String> modules;
  final List<String> skills;
  final List<String> roadmap;
  final List<String> recommendations;

  const ProjectModel({
    required this.projectName,
    required this.domain,
    required this.projectType,
    required this.difficulty,
    required this.progress,
    required this.estimatedDuration,
    required this.teamSize,
    required this.description,
    required this.technologies,
    required this.modules,
    required this.skills,
    required this.roadmap,
    required this.recommendations,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectName: json["projectName"] ?? "",
      domain: json["domain"] ?? "",
      projectType: json["projectType"] ?? "",
      difficulty: json["difficulty"] ?? "",
      progress: json["progress"] ?? 0,
      estimatedDuration: json["estimatedDuration"] ?? "",
      teamSize: json["teamSize"] ?? "",
      description: json["description"] ?? "",

      technologies: List<String>.from(
        json["technologies"] ?? [],
      ),

      modules: (json["modules"] as List? ?? [])
          .map((e) => e["name"].toString())
          .toList(),

      skills: List<String>.from(
        json["skills"] ?? [],
      ),

      roadmap: (json["roadmap"] as List? ?? [])
          .map((e) => e["phase"].toString())
          .toList(),

      recommendations: List<String>.from(
        json["recommendations"] ?? [],
      ),
    );
  }
}