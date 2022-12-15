import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CommentRepo {
  final ApiClient apiClient;

  CommentRepo({required this.apiClient});

  Future<Response> getAllCommentData(String url) async {
    return await apiClient.getData("$url?page=1");
  }

  Future<Response> getAllGroupCommentData(int postId, int groupID) async {
    return await apiClient.getData('/posts/group/$groupID/$postId/comment/');
  }

  Future<Response> addComment(String url, String comment) async {
    return await apiClient.postData('${url}create/', {"comment": comment});
  }

  Future<Response> addReply(String url, String commentID, String comment) async {
    return await apiClient.postData('$url$commentID/reply/', {"comment": comment});
  }
}
