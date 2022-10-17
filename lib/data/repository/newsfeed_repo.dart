import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NewsfeedRepo {
  final ApiClient apiClient;

  NewsfeedRepo({required this.apiClient});

  Future<Response> getNewsFeedData(int page) async {
    return await apiClient.getData(AppConstant.newsFeedURI + page.toString());
  }

  Future<Response> addLike(int postID) async {
    return await apiClient.postData('/posts/$postID/like/', {});
  }
  Future<Response> addLikeONGroup(int postID,int groupID) async {
    return await apiClient.postData('/posts/group/$groupID/$postID/like/', {});
  }
}
