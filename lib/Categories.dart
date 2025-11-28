import 'package:flutter/material.dart';
import 'package:nav1/Doctorpage.dart';
import 'package:nav1/homepage.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allCategories = [
      ...homeCategoriesGrid,
      {
        "name": "Psychology",
        "icon": Icons.psychology,
        "color": Color(0xffFF8A65),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          itemCount: allCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final item = allCategories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DoctorsPage(
                      categoryName: item["name"],
                      doctors: doctors,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: item["color"],
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: item["color"].withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                      ),
                      child: Icon(item["icon"], color: Colors.white, size: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item["name"],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
