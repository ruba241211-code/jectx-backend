import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class AIProjectScreen extends StatefulWidget {
  const AIProjectScreen({super.key});

  @override
  State<AIProjectScreen> createState() => _AIProjectScreenState();
}

class _AIProjectScreenState extends State<AIProjectScreen> {

  String selectedField = "AI";
  String selectedLevel = "Beginner";

  final TextEditingController ideaController =
      TextEditingController();

  String customIdea = "";

  bool isLoading = false;


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


  String generatedIdeas = "";


  Future<void> generateIdeas() async {

    setState(() {
      isLoading = true;
      generatedIdeas = "";
    });


    String result = await AIService.generateProjectIdea(
      selectedField,
      selectedLevel,
    );


    setState(() {
      isLoading = false;
      generatedIdeas = result;
    });

  }



  Future<void> generateCustomIdea() async {

    if (ideaController.text.isEmpty) {
      return;
    }


    setState(() {
      customIdea = "Generating...";
    });


    String result = await AIService.generateProjectIdea(
      ideaController.text,
      selectedLevel,
    );


    setState(() {
      customIdea = result;
    });

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Idea Generator",
        ),
        centerTitle: true,
      ),


      body: Padding(

        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [


            const Text(
              "Choose Project Field",
              style: TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
              ),
            ),


            const SizedBox(height:10),


            DropdownButtonFormField<String>(

              value:selectedField,

              items: fields.map((field){

                return DropdownMenuItem(

                  value:field,

                  child:Text(field),

                );

              }).toList(),


              onChanged:(value){

                setState(() {

                  selectedField=value!;

                });

              },


              decoration:const InputDecoration(
                border:OutlineInputBorder(),
              ),

            ),



            const SizedBox(height:20),



            const Text(
              "Difficulty Level",
              style:TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
              ),
            ),


            const SizedBox(height:10),



            DropdownButtonFormField<String>(

              value:selectedLevel,


              items:levels.map((level){

                return DropdownMenuItem(

                  value:level,

                  child:Text(level),

                );

              }).toList(),


              onChanged:(value){

                setState(() {

                  selectedLevel=value!;

                });

              },


              decoration:const InputDecoration(
                border:OutlineInputBorder(),
              ),

            ),



            const SizedBox(height:20),



            ElevatedButton(

              onPressed:isLoading ? null : generateIdeas,

              child: Text(
                isLoading
                ? "Generating..."
                : "Generate Ideas",
              ),

            ),



            const SizedBox(height:20),



            if(generatedIdeas.isNotEmpty)

              Card(

                child:Padding(

                  padding:
                  const EdgeInsets.all(12),

                  child:Text(
                    generatedIdeas,
                    style:
                    const TextStyle(
                      fontSize:16,
                    ),
                  ),

                ),

              ),



            const SizedBox(height:30),



            const Text(
              "Ask For More Ideas",
              style:TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
              ),
            ),



            const SizedBox(height:10),



            TextField(

              controller:ideaController,

              decoration:const InputDecoration(

                hintText:
                "Example: Robotics project",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:10),



            ElevatedButton(

              onPressed:generateCustomIdea,

              child:const Text(
                "Generate Custom Idea",
              ),

            ),



            const SizedBox(height:20),



            if(customIdea.isNotEmpty)

              Card(

                child:Padding(

                  padding:
                  const EdgeInsets.all(12),

                  child:Text(
                    customIdea,
                    style:
                    const TextStyle(
                      fontSize:16,
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