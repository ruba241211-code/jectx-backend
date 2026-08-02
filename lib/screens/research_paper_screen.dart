import 'package:flutter/material.dart';
import '../services/research_service.dart';

class ResearchPaperScreen extends StatefulWidget {
  const ResearchPaperScreen({super.key});

  @override
  State<ResearchPaperScreen> createState() =>
      _ResearchPaperScreenState();
}

class _ResearchPaperScreenState
    extends State<ResearchPaperScreen> {

  final TextEditingController searchController =
      TextEditingController();

  List<dynamic> papers = [];

  bool loading = false;

  Future<void> searchPapers() async {
    if (searchController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      loading = true;
    });

    final result = await ResearchService.searchPapers(
      searchController.text.trim(),
    );

    setState(() {
      papers = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Research Papers"),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: searchController,

              decoration: const InputDecoration(

                hintText: "Search your project",

                prefixIcon: Icon(Icons.search),

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 15),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: searchPapers,

                child: const Text("Search Papers"),

              ),

            ),

            const SizedBox(height: 20),

            if (loading)
              const CircularProgressIndicator(),

            if (!loading)

              Expanded(

                child: papers.isEmpty

                    ? const Center(
                        child: Text(
                          "Search a project to view research papers.",
                          style: TextStyle(fontSize: 16),
                        ),
                      )

                    : ListView.builder(

                        itemCount: papers.length,

                        itemBuilder: (context, index) {

                          final paper = papers[index];

                          return Card(

                            margin: const EdgeInsets.only(bottom: 12),

                            child: Padding(

                              padding: const EdgeInsets.all(15),

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Text(

                                    paper["title"] ?? "No Title",

                                    style: const TextStyle(

                                      fontSize: 18,

                                      fontWeight:
                                          FontWeight.bold,

                                    ),

                                  ),

                                  const SizedBox(height: 8),
                                  Text(
                                    "👤 Authors: ${(paper["authors"] as List?)?.join(", ") ?? "Unknown"}",
                                  ),
                                  Text(
                                    "📅 Year: ${paper["year"]}",
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    "🔗 ${paper["url"]}",
                                  ),

                                ],

                              ),

                            ),

                          );

                        },

                      ),

              ),

          ],

        ),

      ),

    );

  }

}