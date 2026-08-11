import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/research_service.dart';
import '../services/favourite_service.dart';

class ResearchPaperScreen extends StatefulWidget {
  const ResearchPaperScreen({super.key});

  @override
  State<ResearchPaperScreen> createState() =>
      _ResearchPaperScreenState();
}

class _ResearchPaperScreenState extends State<ResearchPaperScreen> {
  final TextEditingController searchController =
      TextEditingController();

  List papers = [];
  bool loading = false;

  // ==================================================
  // SEARCH PAPERS
  // ==================================================

  Future<void> searchPapers() async {
    if (searchController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a project name."),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    final result = await ResearchService.searchPapers(
      searchController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      papers = result;
      loading = false;
    });
  }

  // ==================================================
  // VIEW PAPER
  // ==================================================

  Future<void> viewPaper(String url) async {
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paper link is not available."),
        ),
      );
      return;
    }

    final uri = Uri.parse(url);

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open the research paper."),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Could not open paper: $e",
          ),
        ),
      );
    }
  }

  // ==================================================
  // COPY PAPER LINK
  // ==================================================

  Future<void> copyPaperLink(String url) async {
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paper link is not available."),
        ),
      );
      return;
    }

    await Clipboard.setData(
      ClipboardData(text: url),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Research paper link copied successfully!",
        ),
      ),
    );
  }

  // ==================================================
  // TOGGLE FAVOURITE
  // ==================================================

  Future<void> toggleFavourite({
    required String title,
    required String description,
    required String url,
  }) async {
    final isSaved = await FavouriteService.isFavourite(
      type: "research_paper",
      title: title,
    );

    if (isSaved) {
      await FavouriteService.removeFavourite(
        type: "research_paper",
        title: title,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Removed from favourites."),
        ),
      );
    } else {
      await FavouriteService.addFavourite(
        type: "research_paper",
        title: title,
        description: description,
        url: url,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added to favourites ❤️"),
        ),
      );
    }

    setState(() {});
  }

  // ==================================================
  // CHECK FAVOURITE
  // ==================================================

  Future<bool> checkFavourite(String title) async {
    return await FavouriteService.isFavourite(
      type: "research_paper",
      title: title,
    );
  }

  // ==================================================
  // DISPOSE
  // ==================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ==================================================
  // UI
  // ==================================================

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

            // ==================================================
            // SEARCH FIELD
            // ==================================================

            TextField(
              controller: searchController,

              textInputAction: TextInputAction.search,

              onSubmitted: (_) {
                searchPapers();
              },

              decoration: InputDecoration(
                hintText: "Search your project",

                prefixIcon: const Icon(
                  Icons.search,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ==================================================
            // SEARCH BUTTON
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(
                onPressed: loading
                    ? null
                    : searchPapers,

                icon: const Icon(
                  Icons.search,
                ),

                label: const Text(
                  "Search Papers",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // LOADING
            // ==================================================

            if (loading)

              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )

            // ==================================================
            // RESULTS
            // ==================================================

            else

              Expanded(
                child: papers.isEmpty

                    ? const Center(
                        child: Text(
                          "Search a project to view research papers.",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )

                    : ListView.builder(
                        itemCount: papers.length,

                        itemBuilder: (
                          context,
                          index,
                        ) {
                          final paper = papers[index];

                          final authors =
                              (paper["authors"] as List?) ??
                                  [];

                          final title =
                              paper["title"] ??
                                  "No Title";

                          final year =
                              paper["year"] ??
                                  "Unknown";

                          final url =
                              paper["url"] ??
                                  "";

                          return Card(
                            margin:
                                const EdgeInsets.only(
                              bottom: 15,
                            ),

                            elevation: 4,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                15,
                              ),
                            ),

                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                16,
                              ),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  // ==================================================
                                  // TITLE + FAVOURITE
                                  // ==================================================

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: [

                                      Expanded(
                                        child: Text(
                                          title,

                                          style:
                                              const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      FutureBuilder<bool>(
                                        future: checkFavourite(
                                          title,
                                        ),

                                        builder:
                                            (
                                          context,
                                          snapshot,
                                        ) {
                                          final isFavourite =
                                              snapshot.data ??
                                                  false;

                                          return IconButton(
                                            tooltip:
                                                isFavourite
                                                    ? "Remove from favourites"
                                                    : "Add to favourites",

                                            icon: Icon(
                                              isFavourite
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border,

                                              color:
                                                  isFavourite
                                                      ? Colors.red
                                                      : null,
                                            ),

                                            onPressed: () {
                                              toggleFavourite(
                                                title: title,
                                                description:
                                                    "Authors: ${authors.isEmpty ? "Unknown" : authors.join(", ")} | Year: $year",
                                                url: url,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),

                                  // ==================================================
                                  // AUTHORS
                                  // ==================================================

                                  Text(
                                    "👤 Authors: "
                                    "${authors.isEmpty ? "Unknown" : authors.join(", ")}",
                                  ),

                                  const SizedBox(
                                    height: 7,
                                  ),

                                  // ==================================================
                                  // YEAR
                                  // ==================================================

                                  Text(
                                    "📅 Year: $year",
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // ==================================================
                                  // URL
                                  // ==================================================

                                  if (url.isNotEmpty)

                                    SelectableText(
                                      url,

                                      style:
                                          const TextStyle(
                                        color: Colors.blue,
                                        decoration:
                                            TextDecoration
                                                .underline,
                                      ),
                                    ),

                                  const SizedBox(
                                    height: 15,
                                  ),

                                  // ==================================================
                                  // COPY LINK
                                  // ==================================================

                                  SizedBox(
                                    width:
                                        double.infinity,

                                    child:
                                        ElevatedButton
                                            .icon(
                                      icon: const Icon(
                                        Icons.copy,
                                      ),

                                      label: const Text(
                                        "Copy Research Paper Link",
                                      ),

                                      onPressed: () {
                                        copyPaperLink(
                                          url,
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // ==================================================
                                  // VIEW PAPER
                                  // ==================================================

                                  SizedBox(
                                    width:
                                        double.infinity,

                                    child:
                                        ElevatedButton
                                            .icon(
                                      icon: const Icon(
                                        Icons.open_in_new,
                                      ),

                                      label: const Text(
                                        "View Paper",
                                      ),

                                      onPressed: () {
                                        viewPaper(
                                          url,
                                        );
                                      },
                                    ),
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