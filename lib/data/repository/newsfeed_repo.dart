import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NewsfeedRepo {
  final ApiClient apiClient;

  NewsfeedRepo({required this.apiClient});

  Future<Response> getNewsFeedData(int page) async {
    return await apiClient.getData(AppConstant.newsFeedURI + page.toString());
  }

  Future<Response> addLike(int postID, {bool isGroup = false, bool isFromLike = false, int groupPageID = 0}) async {
    if (isGroup) {
      return await apiClient.postData('/posts/group/$groupPageID/$postID/like/', {});
    } else if (isFromLike) {
      return await apiClient.postData('/posts/$postID/like/', {});
    } else {
      return await apiClient.postData('/posts/$postID/like/', {});
    }
  }

  Future<Response> addLikeONGroup(int postID, int groupID) async {
    return await apiClient.postData('/posts/group/$groupID/$postID/like/', {});
  }

  Future<Response> addLikeONPage(int postID, int groupID) async {
    return await apiClient.postData('/posts/page/$groupID/$postID/like/', {});
  }

  Future<Response> callForSinglePostFromNotification(String url) async {
    return await apiClient.getData(url);
  }

  Future<Response> callForgetLikedShareUser(String url, int pageNo) async {
    return await apiClient.getData('$url?page=$pageNo&size=20');
  }
}
