import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_colors.dart';
import '../widgets/dashboard_card.dart';

import 'idea_generator_screen.dart';
import 'research_paper_screen.dart';
import 'favourites_screen.dart';
import 'package:jectx/features/project_details/screens/project_details_input_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // =========================
  // LOGOUT FUNCTION
  // =========================

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('isLoggedIn');

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  // =========================
  // LOGOUT CONFIRMATION
  // =========================

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                logout(context);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Column(
          children: [
            Text(
              "JECTX",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Build Your Project from Idea to Reality",
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),

        // =========================
        // LOGOUT BUTTON
        // =========================

        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 25,
            ),
            tooltip: "Logout",
            onPressed: () {
              showLogoutDialog(context);
            },
          ),
        ],
      ),

      // =========================
      // BODY
      // =========================

      body: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // =========================
            // WELCOME
            // =========================

            const Text(
              "👋 Welcome",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Everything you need to build your project.",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.subtitle,
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // SEARCH
            // =========================

            TextField(
              decoration: InputDecoration(
                hintText: "Search Projects...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // PROJECT BUILDER
            // =========================

            const Text(
              "Project Builder",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // DASHBOARD GRID
            // =========================

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [
                  // =========================
                  // IDEA GENERATOR
                  // =========================

                  DashboardCard(
                    icon: Icons.lightbulb_outline,
                    title: "Idea Generator",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const IdeaGeneratorScreen(),
                        ),
                      );
                    },
                  ),

                  // =========================
                  // RESEARCH PAPERS
                  // =========================

                  DashboardCard(
                    icon: Icons.article_outlined,
                    title: "Research Papers",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ResearchPaperScreen(),
                        ),
                      );
                    },
                  ),

                  // =========================
                  // PROJECT DETAILS
                  // =========================

                  DashboardCard(
                    icon: Icons.assignment_outlined,
                    title: "Project Details",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProjectDetailsInputScreen(),
                        ),
                      );
                    },
                  ),

                  // =========================
                  // DESIGN
                  // =========================

                  DashboardCard(
                    icon: Icons.design_services_outlined,
                    title: "Design",
                    onTap: () {},
                  ),

                  // =========================
                  // CODING
                  // =========================

                  DashboardCard(
                    icon: Icons.code,
                    title: "Coding",
                    onTap: () {},
                  ),

                  // =========================
                  // FAVOURITES
                  // =========================

                  DashboardCard(
                    icon: Icons.favorite_outline,
                    title: "Favourite",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FavouritesScreen(),
                        ),
                      );
                    },
                  ),

                  // =========================
                  // EXPORT PDF
                  // =========================

                  DashboardCard(
                    icon: Icons.picture_as_pdf,
                    title: "Export PDF",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}