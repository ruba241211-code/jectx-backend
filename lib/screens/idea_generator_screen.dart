import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class IdeaGeneratorScreen extends StatefulWidget {
  const IdeaGeneratorScreen({super.key});

  @override
  State<IdeaGeneratorScreen> createState() =>
      _IdeaGeneratorScreenState();
}

class _IdeaGeneratorScreenState extends State<IdeaGeneratorScreen> {
  String selectedField = "AI";
  String selectedLevel = "Beginner";

  bool isLoading = false;
  String result = "";

  final List<String> fields = [
    "AI",
    "Medical",
    "Engineering",
    "Web Development",
    "IoT",
    "Robotics",
    "Education",
    "Agriculture",
  ];

  final List<String> levels = [
    "Beginner",
    "Intermediate",
    "Advanced",
  ];

  Future<void> generateIdeas() async {
    setState(() {
      isLoading = true;
      result = "";
    });

    try {
      final response = await AIService.generateProjectIdea(
        selectedField,
        selectedLevel,
      );

      if (!mounted) return;

      setState(() {
        result = response;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        result = "Error: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Idea Generator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Project Field",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: fields.map((field) {
                return DropdownMenuItem<String>(
                  value: field,
                  child: Text(field),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedField = value;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Difficulty",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedLevel,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: levels.map((level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedLevel = value;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : generateIdeas,
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Generate Ideas",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            if (result.isNotEmpty)
              _buildResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    final projects = _parseProjects(result);

    if (projects.isEmpty) {
      return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            result,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Generated Project Ideas",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ...projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;

          return _ProjectIdeaCard(
            number: index + 1,
            title: project["title"] ?? "Untitled Project",
            description:
                project["description"] ?? "No description available.",
          );
        }),
      ],
    );
  }

  List<Map<String, String>> _parseProjects(String text) {
    final List<Map<String, String>> projects = [];

    final blocks = text.split(
      RegExp(r'────────────────────────────|----------------------------'),
    );

    for (final block in blocks) {
      if (!block.contains("Project Name:")) {
        continue;
      }

      String title = "";
      String description = "";

      final titleMatch = RegExp(
        r'Project Name:\s*(.*?)(?=\n\nDescription:)',
        dotAll: true,
      ).firstMatch(block);

      final descriptionMatch = RegExp(
        r'Description:\s*(.*?)(?=\n\nTechnologies:|\n\nDifficulty:|$)',
        dotAll: true,
      ).firstMatch(block);

      if (titleMatch != null) {
        title = titleMatch.group(1)?.trim() ?? "";
      }

      if (descriptionMatch != null) {
        description = descriptionMatch.group(1)?.trim() ?? "";
      }

      if (title.isNotEmpty) {
        projects.add({
          "title": title,
          "description": description,
        });
      }
    }

    return projects;
  }
}

class _ProjectIdeaCard extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const _ProjectIdeaCard({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "$number",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}