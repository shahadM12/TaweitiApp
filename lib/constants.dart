import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

String UID = '';
List<bool> seasonsKeys = [false, false, false];
List<List<bool>> videosInSeasons = [
  [false, false, false],
  [false, false, false, false],
  [false, false, false]
];

void onVideoEnd(controller, seasonNum, videoNum) {
  if (controller.value.position == controller.value.duration) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .collection('seasons')
        .doc(seasonNum)
        .collection('videos')
        .doc(videoNum)
        .set({'finishVideo': true});
    videosInSeasons[int.parse(seasonNum)-1][int.parse(videoNum)-1] = true;
  }
}

class questions {
  final String que;
  final List<String> imagesURL;
  final int ans;
  final String audio;

  questions(this.que, this.imagesURL, this.ans, this.audio);
}
