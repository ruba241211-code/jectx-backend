import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/dashboard_card.dart';
import 'idea_generator_screen.dart';
import 'research_paper_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

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
      ),


      body: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),


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



            const Text(
              "Project Builder",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),



            const SizedBox(height: 15),



            Expanded(

              child: GridView.count(

                crossAxisCount: 2,

                crossAxisSpacing: 15,

                mainAxisSpacing: 15,


                children: [


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



                  DashboardCard(
  icon: Icons.article_outlined,
  title: "Research Papers",

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResearchPaperScreen(),
      ),
    );
  },
),



                  DashboardCard(
                    icon: Icons.assignment_outlined,
                    title: "Project Details",

                    onTap: () {},
                  ),



                  DashboardCard(
                    icon: Icons.design_services_outlined,
                    title: "Design",

                    onTap: () {},
                  ),



                  DashboardCard(
                    icon: Icons.code,
                    title: "Coding",

                    onTap: () {},
                  ),



                  DashboardCard(
                    icon: Icons.favorite_outline,
                    title: "Favourite",

                    onTap: () {},
                  ),



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