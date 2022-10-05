import 'package:als_frontend/old_code/model/group%20page/group/author_group_details_model.dart';
import 'package:als_frontend/old_code/service/like/timeline_post_like_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/group page/group_details_service.dart';

class GroupDetailsProvider extends ChangeNotifier {
  AuthorGroupDetailsModel? groupDetails;
  var isLoaded = false;
  int groupIndex = 0;
  List<String> postImages = [];
  List<int> likesStatusAllData = [];

  bool isLoading=false;

  Future<void> getData() async {
    isLoading=true;
    groupDetails = (await GroupDetailsService(groupIndex: groupIndex).getgroups());
    initializeLikedData();
    isLoading=false;
    notifyListeners();
    if (groupDetails != null) {
      isLoaded = true;
      notifyListeners();
    }
  }


  initializeLikedData() async {
    likesStatusAllData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = (prefs.getInt('id') ?? 0);
    int status = 0;
    for (int i = 0; i < groupDetails!.posts!.length; i++) {
      status = 0;
      likesStatusAllData.add(0);
      groupDetails!.posts![i].likedBy!.forEach((e) {
        if (e.id == id) {
          status = 1;
          return;
        }
      });
      if (status == 0) {
        likesStatusAllData[i] = 0;
      } else {
        likesStatusAllData[i] = 1;
      }
    }
    likesStatusAllData.add(0);
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    groupDetails!.posts![index].totalComment = groupDetails!.posts![index].totalComment! + 1;
    notifyListeners();
  }

  addLike(int postID, int index) async {
    bool status = await TimelinePostLikeService.addLiked(postID);
    if (status == true) {
      likesStatusAllData[index] = 1;
      groupDetails!.posts![index].totalLike = groupDetails!.posts![index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      groupDetails!.posts![index].totalLike = groupDetails!.posts![index].totalLike! - 1;
    }
    notifyListeners();
  }

}
