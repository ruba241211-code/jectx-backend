import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class IdeaGeneratorScreen extends StatefulWidget {
  const IdeaGeneratorScreen({super.key});

  @override
  State<IdeaGeneratorScreen> createState() =>
      _IdeaGeneratorScreenState();
}

class _IdeaGeneratorScreenState
    extends State<IdeaGeneratorScreen> {

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

    String response =
    await AIService.generateProjectIdea(
  selectedField,
  selectedLevel,
);

    setState(() {
      result = response;
      isLoading = false;
    });
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
                return DropdownMenuItem(
                  value: field,
                  child: Text(field),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedField = value!;
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
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLevel = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : generateIdeas,
                child: const Text(
                  "Generate Ideas",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),

            if (result.isNotEmpty)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              ],
        ),
      ),
    );
  }
}