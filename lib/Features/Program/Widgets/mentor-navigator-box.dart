import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Models/program.dart';
import 'package:flutter/material.dart';

class MentorNavigatorBox extends StatelessWidget {
  const MentorNavigatorBox({
    Key? key,
    required this.themeData,
    required this.trainer,
    required this.courseId,
  }) : super(key: key);

  final TextTheme themeData;
  final TrainerModel trainer;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.mentorInfo,
          arguments: trainer,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    trainer.image,
                    width: 75,
                    height: 75,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (ctx, obj, _) => Image.asset(
                      'assets/Images/user_placeholder.png',
                      width: 75,
                      height: 75,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainer.name,
                    style: themeData.headline3,
                  ),
                  trainer.decription.isNotEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 10,
                          child: Text(
                            trainer.decription,
                            style: themeData.button,
                            maxLines: 2,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 3),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0XFFDDDDDD),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${trainer.courseCount} ACTIVE COURSES',
                            style: themeData.bodyText1!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                FlutterIcons.right_chevron,
                size: 50,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
