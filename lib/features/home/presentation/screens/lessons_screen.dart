import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/core/helper_funcations/video_player_screen.dart';
import 'package:telead/core/styles/app_style.dart';
import 'package:telead/features/home/data/models/lessons_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
                      title: Text(
                        lesson.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('15 Mins'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Container(
                                    height: 400.h,
                                    padding: EdgeInsets.all(10.r),
                                    child: Column(
                                      children: [
                                        // العنوان مع زر الإغلاق
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${lesson.title}',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.close,
                                                  color: Colors.red),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        // عرض الفيديو داخل النافذة
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            child: VideoPlayerScreen(
                                                videoUrl: lesson.video_url),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.play_circle,
                              color: Color(0xff0961F5),
                              size: 24.r,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Container(
                                    height: 600.h, // ضبط ارتفاع مناسب
                                    // ضبط عرض مناسب
                                    child: Column(
                                      children: [
                                        // العنوان وشريط الإغلاق
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${lesson.title}.pdf",
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close,
                                                    color: Colors.red),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        // عرض ملف PDF
                                        Expanded(
                                          child: SfPdfViewer.network(
                                              lesson.pdf_url),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.file_open,
                              color: Color(0xff0961F5),
                              size: 24.r,
                            ),
                          ),
                        ],
                      ),
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
