import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CommentRepo {
  final ApiClient apiClient;

  CommentRepo({required this.apiClient});

  Future<Response> getAllCommentData(int postId) async {
    return await apiClient.getData('/posts/$postId/comment/');
  }

  Future<Response> addComment(int postId, String comment) async {
    return await apiClient.postData('/posts/$postId/comment/create/', {"comment": comment});
  }
}
