import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_routes.dart';
import 'package:game_app/feature/home/view/widget/home_option_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('افلام من غير كلام')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            HomeOptionCard(
              title: "فريق ضد فريق",
              subtitle: "تنافس بين فريقين في تحديات ممتعة",
              icon: Icons.groups,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.teamSetupRoute);
              },
            ),

            const SizedBox(height: 16),

            HomeOptionCard(
              title: "فرد ضد مجموعة",
              subtitle: "شخص واحد يواجه فريق كامل",
              icon: Icons.person,
              onTap: () {},
            ),

            const SizedBox(height: 16),

            HomeOptionCard(
              title: "خمن ماذا معي",
              subtitle: "لعبة التخمين والتحدي",
              icon: Icons.help_outline,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

   
  
  }


/*
Center(
        child: Column(
          children: [
            const Text('Hello, World!'),
            FlipCard(
              front: Container(
                width: 250,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/card1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Center(
                //   child: Icon(
                //     Icons.movie_creation,
                //     color: Colors.deepPurple,
                //     size: 100,
                //   ),
                // ),
              ),

              back: Container(
  width: 250,
  height: 350,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.black, width: 2),
    boxShadow: const [
      BoxShadow(
        blurRadius: 10,
        offset: Offset(0, 5),
        color: Colors.black26,
      ),
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "A",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Spacer(),

        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.movie),
                SizedBox(width: 8),
                Text("اسم الفيلم"),
              ],
            ),

            SizedBox(height: 16),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tv),
                SizedBox(width: 8),
                Text("اسم المسلسل"),
              ],
            ),

            SizedBox(height: 16),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.theater_comedy),
                SizedBox(width: 8),
                Text("اسم المسرحية"),
              ],
            ),
          ],
        ),

        const Spacer(),

        const Align(
          alignment: Alignment.bottomRight,
          child: RotatedBox(
            quarterTurns: 2,
            child: Text(
              "A",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
)
            ),
          ],
        ),
      ),
 */