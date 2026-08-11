import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/favourite_service.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Map<String, dynamic>> favourites = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  // ============================================================
  // LOAD FAVOURITES
  // ============================================================

  Future<void> loadFavourites() async {
    setState(() {
      loading = true;
    });

    final result = await FavouriteService.getFavourites();

    if (!mounted) return;

    setState(() {
      favourites = result;
      loading = false;
    });
  }

  // ============================================================
  // REMOVE FAVOURITE
  // ============================================================

  Future<void> removeFavourite(
    String type,
    String title,
  ) async {
    await FavouriteService.removeFavourite(
      type: type,
      title: title,
    );

    await loadFavourites();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Removed from favourites."),
      ),
    );
  }

  // ============================================================
  // VIEW PAPER
  // ============================================================

  Future<void> viewPaper(String url) async {
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paper link is not available."),
        ),
      );
      return;
    }

    try {
      final uri = Uri.parse(url);

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
        const SnackBar(
          content: Text("Could not open the research paper."),
        ),
      );
    }
  }

  // ============================================================
  // GET ICON
  // ============================================================

  IconData getFavouriteIcon(String type) {
    switch (type) {
      case "research_paper":
        return Icons.article;

      case "project_idea":
        return Icons.lightbulb;

      case "project":
        return Icons.folder;

      default:
        return Icons.favorite;
    }
  }

  // ============================================================
  // GET TYPE NAME
  // ============================================================

  String getFavouriteType(String type) {
    switch (type) {
      case "research_paper":
        return "Research Paper";

      case "project_idea":
        return "Project Idea";

      case "project":
        return "Project";

      default:
        return "Favourite";
    }
  }

  // ============================================================
  // CLEAR ALL
  // ============================================================

  Future<void> clearAllFavourites() async {
    if (favourites.isEmpty) {
      return;
    }

    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Clear Favourites?"),
          content: const Text(
            "Are you sure you want to remove all favourites?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Clear All"),
            ),
          ],
        );
      },
    );

    if (shouldClear != true) {
      return;
    }

    await FavouriteService.clearAll();

    await loadFavourites();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All favourites cleared."),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        centerTitle: true,

        actions: [
          if (favourites.isNotEmpty)
            IconButton(
              tooltip: "Clear all",
              icon: const Icon(Icons.delete_sweep),
              onPressed: clearAllFavourites,
            ),
        ],
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : favourites.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: loadFavourites,

                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),

                    itemCount: favourites.length,

                    itemBuilder: (context, index) {
                      final favourite = favourites[index];

                      final type =
                          favourite["type"] ?? "";

                      final title =
                          favourite["title"] ??
                              "Untitled";

                      final description =
                          favourite["description"] ??
                              "";

                      final url =
                          favourite["url"] ??
                              "";

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 15,
                        ),

                        elevation: 4,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),

                        child: Padding(
                          padding:
                              const EdgeInsets.all(16),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              // ==================================================
                              // TOP ROW
                              // ==================================================

                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Container(
                                    width: 45,
                                    height: 45,

                                    decoration:
                                        BoxDecoration(
                                      color: Colors
                                          .deepPurple
                                          .withOpacity(0.1),

                                      borderRadius:
                                          BorderRadius
                                              .circular(12),
                                    ),

                                    child: Icon(
                                      getFavouriteIcon(
                                        type,
                                      ),

                                      color:
                                          Colors.deepPurple,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 12,
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(
                                          getFavouriteType(
                                            type,
                                          ),

                                          style:
                                              TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                                FontWeight.w600,
                                            color: Colors
                                                .deepPurple,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 4,
                                        ),

                                        Text(
                                          title,

                                          style:
                                              const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  IconButton(
                                    tooltip:
                                        "Remove favourite",

                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),

                                    onPressed: () {
                                      removeFavourite(
                                        type,
                                        title,
                                      );
                                    },
                                  ),
                                ],
                              ),

                              // ==================================================
                              // DESCRIPTION
                              // ==================================================

                              if (description
                                  .toString()
                                  .isNotEmpty) ...[
                                const SizedBox(
                                  height: 14,
                                ),

                                Text(
                                  description,

                                  maxLines: 4,
                                  overflow:
                                      TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.5,
                                    color: Colors
                                        .grey
                                        .shade700,
                                  ),
                                ),
                              ],

                              // ==================================================
                              // VIEW PAPER
                              // ==================================================

                              if (type ==
                                      "research_paper" &&
                                  url
                                      .toString()
                                      .isNotEmpty) ...[
                                const SizedBox(
                                  height: 14,
                                ),

                                SizedBox(
                                  width:
                                      double.infinity,

                                  child:
                                      ElevatedButton
                                          .icon(
                                    icon: const Icon(
                                      Icons
                                          .open_in_new,
                                    ),

                                    label: const Text(
                                      "View Paper",
                                    ),

                                    onPressed: () {
                                      viewPaper(
                                        url.toString(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 20),

            const Text(
              "No Favourites Yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Save research papers, project ideas, "
              "and projects to find them easily later.",

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}