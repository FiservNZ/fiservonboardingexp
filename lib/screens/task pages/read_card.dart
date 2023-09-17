import 'package:fiservonboardingexp/controllers/read_controller.dart';
import 'package:fiservonboardingexp/model/read_model.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/app_icon_text.dart';

class ReadCard extends GetView<ReadController> {
  final ReadModel model;

  const ReadCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: darkTileColor /*Theme.of(context).cardColor*/),
      child: InkWell(
        onTap: () {
          // Open a popup dialog when the card is tapped
          //print('${model.title}');
          controller.showPopupAlertDialog(readModel: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side of the card containing an icon or image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        // child: CachedNetworkImage(
                        //   imageUrl: model.imageUrl!,
                        //   placeholder: (context, url) => Container(
                        //     alignment: Alignment.center,
                        //     child: const CircularProgressIndicator(),
                        //   ),
                        //   errorWidget: (context, url, error) =>
                        //       Image.asset("assets/images/Fiserv_logo.png"),
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title of the read task
                        Text(model.title,
                            style: TextStyle(
                                color: darkTextColor,
                                // color: UIParameters.isDarkMode()
                                //     ? Theme.of(context)
                                //         .textTheme
                                //         .bodySmall!
                                //         .color
                                //     : Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 15),

                          // Description of the read task
                          child: Text(
                            model.description,
                            style: TextStyle(color: darkTextColor),
                          ),
                        ),
                        Row(children: [
                          // Icon representing time, followed by text
                          AppIconText(
                            icon: Icon(
                              Icons.timer,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                            ),
                            text: Text(
                              //model.timeConverter(),
                              'time',
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  fontSize: 12),
                            ),
                          )
                        ])
                      ],
                    ),
                  )
                ],
              ),

              // Play button icon positioned at the bottom right corner
              Positioned(
                  bottom: -padding,
                  right: -padding,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 43, 42, 42),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardBorderPadding),
                              bottomRight: Radius.circular(cardBorderPadding))),
                      child: const Icon(Icons.play_arrow_rounded,
                          color: fiservColor),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
