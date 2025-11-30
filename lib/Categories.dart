import 'package:flutter/material.dart';
import 'package:nav1/Doctorpage.dart';
// import 'package:nav1/homepage.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.name,
    required this.icon,
    required this.color,
  });
}

final List<Category> homeCategories = [
  Category(name: "Cardiology", icon: Icons.favorite, color: Color(0xffE57373)),
  Category(name: "Eyes", icon: Icons.remove_red_eye, color: Color(0xff64B5F6)),
  Category(name: "Bones", icon: Icons.accessibility_new, color: Color(0xff81C784)),
  Category(name: "Dermatology", icon: Icons.face, color: Color(0xffBA68C8)),
  Category(name: "Dentist", icon: Icons.medical_services, color: Color(0xffFFD54F)),
  Category(name: "Neurology", icon: Icons.psychology, color: Color(0xff4DD0E1)),
  Category(name: "Psychology", icon: Icons.psychology_outlined, color: Color(0xffFF8A65)),
 
];

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
   final List<Category> allCategories = [
  ...homeCategories,
  Category(name: "Hematology", icon: Icons.bloodtype, color: Color(0xffEC407A)),
Category(name: "Rheumatology", icon: Icons.accessibility, color: Color(0xffFFA726)),
Category(name: "Pulmonology", icon: Icons.air, color: Color(0xff26A69A)),
Category(name: "Psychiatry", icon: Icons.self_improvement, color: Color(0xff8D6E63)),
Category(name: "Radiology", icon: Icons.radio, color: Color(0xff5C6BC0)),
Category(name: "Infectious Diseases", icon: Icons.coronavirus, color: Color(0xff66BB6A)),
 Category(name: "Pediatrics", icon: Icons.child_care, color: Color(0xff4DB6AC)),
  Category(name: "Orthopedics", icon: Icons.fitness_center, color: Color(0xff9575CD)),
  Category(name: "ENT", icon: Icons.hearing, color: Color(0xffF06292)),
  Category(name: "Gynecology", icon: Icons.pregnant_woman, color: Color(0xffFFB74D)),
  Category(name: "General Surgery", icon: Icons.medical_services_outlined, color: Color(0xff4FC3F7)),
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
                      categoryName: item.name,
                      doctors: doctors,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: item.color.withOpacity(0.4),
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
                      child: Icon(item.icon, color: Colors.white, size: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
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
