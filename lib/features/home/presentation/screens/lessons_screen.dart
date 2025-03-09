import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/core/helper_funcations/video_player_function.dart';
import 'package:telead/core/styles/app_style.dart';
import 'package:telead/features/home/data/models/lessons_model.dart';

class LessonsScreen extends StatelessWidget {
  final List<LessonsModel> lessons;

  const LessonsScreen({required this.lessons, super.key});

  static const routeName = 'lessons';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F9FF),
        title: Text(
          'Lessons',
          style: AppStyles.style24(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Container(
            width: 360.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: lessons.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final lesson = entry.value;
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(index.toString()),
                        radius: 18.r,
                      ),
                      title: Text(lesson.title),
                      subtitle: Text(' 15 Mins'),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                VideoPlayerFunction(videoUrl: lesson.video_url)
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.play_circle,
                            color: Color(0xff0961F5),
                            size: 20.r,
                          )),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
