// import 'package:fiservonboardingexp/model/watch_model.dart';
// import 'package:fiservonboardingexp/util/constants.dart';
// import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/watch_controller.dart';
// import '../../widgets/app_icon_text.dart';

// class WatchCard extends GetView<WatchController> {
//   final WatchModel model;

//   const WatchCard({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     const double padding = 10.0;
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: UIParameters.cardBorderRadius,
//           color: darkTileColor /*Theme.of(context).cardColor*/),
//       child: InkWell(
//         onTap: () {
//           //print('${model.title}');
//           controller.showPopupAlertDialog(watchModel: model);
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(padding),
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: ColoredBox(
//                       color: Theme.of(context).primaryColor.withOpacity(0.1),
//                       child: SizedBox(
//                         height: Get.width * 0.15,
//                         width: Get.width * 0.15,
//                         // child: CachedNetworkImage(
//                         //   imageUrl: model.imageUrl!,
//                         //   placeholder: (context, url) => Container(
//                         //     alignment: Alignment.center,
//                         //     child: const CircularProgressIndicator(),
//                         //   ),
//                         //   errorWidget: (context, url, error) =>
//                         //       Image.asset("assets/images/Fiserv_logo.png"),
//                         // ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(model.videoTitle,
//                             style: TextStyle(
//                                 color: darkTextColor,
//                                 // color: UIParameters.isDarkMode()
//                                 //     ? Theme.of(context)
//                                 //         .textTheme
//                                 //         .bodySmall!
//                                 //         .color
//                                 //     : Theme.of(context).primaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold)),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0, bottom: 15),
//                           child: Text(
//                             //model.description,
//                             model.popUpDescription,
//                             style: TextStyle(color: darkTextColor),
//                           ),
//                         ),
//                         Row(children: [
//                           AppIconText(
//                             icon: Icon(
//                               Icons.timer,
//                               color: Get.isDarkMode
//                                   ? Colors.white
//                                   : Theme.of(context)
//                                       .primaryColor
//                                       .withOpacity(0.3),
//                             ),
//                             text: Text(
//                               //model.timeConverter(),
//                               'time',
//                               style: TextStyle(
//                                   color: Get.isDarkMode
//                                       ? Colors.white
//                                       : Theme.of(context).primaryColor,
//                                   fontSize: 12),
//                             ),
//                           )
//                         ])
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Positioned(
//                   bottom: -padding,
//                   right: -padding,
//                   child: GestureDetector(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 20),
//                       child: Icon(Icons.play_arrow_rounded, color: fiservColor),
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 43, 42, 42),
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(cardBorderPadding),
//                               bottomRight: Radius.circular(cardBorderPadding))),
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
