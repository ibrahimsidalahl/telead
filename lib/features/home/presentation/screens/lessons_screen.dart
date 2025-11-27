import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/core/helper_funcations/video_player_screen.dart';
import 'package:telead/core/styles/app_style.dart';
import 'package:telead/features/home/data/models/lessons_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LessonsScreen extends StatelessWidget {
  final List<LessonsModel> lessons;

  const LessonsScreen({required this.lessons, super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:    Theme.of(context).scaffoldBackgroundColor,

        elevation: 0,
        title: Text(
          'Lessons',
          style: AppStyles.style24(context).copyWith(color:    Theme.of(context).primaryColor,
        ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(16.r),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            return Card(
              color:Theme.of(context).scaffoldBackgroundColor,

              margin: EdgeInsets.only(bottom: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.all(12.r),
                leading: CircleAvatar(
                  radius: 22.r,
                  backgroundColor: const Color(0xff0961F5),
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  lesson.title,
                  style: TextStyle(
                      color:    Theme.of(context).primaryColor,

                      fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 16.r, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text("15 mins",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                ),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      tooltip: "Watch Video",
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.r)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        lesson.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close,
                                            size: 18.sp,
                                            color: Colors.redAccent),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: VideoPlayerScreen(
                                        videoUrl: lesson.video_url),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.play_circle_fill,
                          color: Color(0xff0961F5), size: 28.r),
                    ),
                    IconButton(
                      tooltip: "Open PDF",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                              appBar: AppBar(
                                title: Text("${lesson.title}.pdf"),
                              ),
                              body: SfPdfViewer.network(lesson.pdf_url),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.picture_as_pdf,
                          color: Colors.redAccent, size: 28.r),
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
