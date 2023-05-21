import 'dart:convert';

import 'package:blog/app/models/response_status.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../constants/api_string.dart';
import '../constants/app_string.dart';
import '../constants/helper_function.dart';
import '../models/api_response.dart';
import '../models/dashboard/like.dart';
import '../models/dashboard/post.dart';

class PostService {
  Future<ApiResponse> getAllPosts() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(getPostsApi);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        apiResponse.data = json.map((item) => Post.fromJson(item)).toList();

        apiResponse.data as List<dynamic>;
        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> getPostsByCategory(String categoryId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(getPostsByCategoryApi + categoryId);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        apiResponse.data = json.map((item) => Post.fromJson(item)).toList();

        apiResponse.data as List<dynamic>;
        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> searchPost(String keyword) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(searchPostApi + keyword);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        apiResponse.data = json.map((item) => Post.fromJson(item)).toList();

        apiResponse.data as List<dynamic>;
        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> getDeletedPosts() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(deletedPostsApi);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        apiResponse.data = json.map((item) => Post.fromJson(item)).toList();

        apiResponse.data as List<dynamic>;
        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> getSavedPosts() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(getSavedPostApi);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        apiResponse.data = json.map((item) => Post.fromJson(item)).toList();

        apiResponse.data as List<dynamic>;
        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> getMyPosts() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(getMyPostsApi);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        apiResponse.data = json.map((item) => Post.fromJson(item)).toList();

        apiResponse.data as List<dynamic>;
        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> likeUnlike(String postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(likeUnlikeApi + postId);

      String token = await getToken();

      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        final responseStatus = ResponseStatus.fromJson(json);
        responseStatus.data = Like.fromJson(json["data"]);

        apiResponse.data = responseStatus;

        //
      } else {
        var json = jsonDecode(response.body);
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> deletePost(String postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(deletePostApi + postId);
      String token = await getToken();
      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.delete(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        apiResponse.data = ResponseStatus.fromJson(json);
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> restorePost(String postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(restorePostApi + postId);
      String token = await getToken();
      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        apiResponse.data = ResponseStatus.fromJson(json);
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> savePost(String postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(savePostApi + postId);
      String token = await getToken();
      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        apiResponse.data = ResponseStatus.fromJson(json);
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> removeSavedPost(String postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(removeSavePostApi + postId);
      String token = await getToken();
      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.delete(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        apiResponse.data = ResponseStatus.fromJson(json);
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> deletePostPermanently(String postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      var url = Uri.parse(deletePostPermenanetApi + postId);
      String token = await getToken();
      var headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};

      var response = await http.delete(url, headers: headers);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        apiResponse.data = ResponseStatus.fromJson(json);
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> createPost(Map<String, dynamic> content, List<String> images) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final token = await getToken();
      var headers = {'Authorization': 'Bearer $token'};

      var url = Uri.parse(createPostApi);

      var request = http.MultipartRequest("POST", url);

      request.headers.addAll(headers);

      for (var img in images) {
        String ext = img.split('.').last;

        var file = await http.MultipartFile.fromPath("images", img, contentType: MediaType('image', ext));
        request.files.add(file);
      }

      request.fields["title"] = content["title"];
      request.fields["description"] = content["description"];
      request.fields["categoryId"] = content["categoryId"];

      final response = await request.send();

      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      final json = jsonDecode(responseString);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // apiResponse.data = ResponseStatus.fromJson(json); //postCount
        final status = ResponseStatus.fromJson(json);

        status.data = json["postCount"] ?? 0;

        apiResponse.data = status;
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }

  Future<ApiResponse> editPost(Map<String, dynamic> content, List<String> images, List<String> deletedImages) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final token = await getToken();
      var headers = {'Authorization': 'Bearer $token'};

      var url = Uri.parse(editPostApi);

      var request = http.MultipartRequest("POST", url);

      request.headers.addAll(headers);

      for (var img in images) {
        String ext = img.split('.').last;

        var file = await http.MultipartFile.fromPath("images", img, contentType: MediaType('image', ext));
        request.files.add(file);
      }

      print(content);

      request.fields["deletedThumbnail"] = content["deletedThumbnail"] ?? "";

      request.fields["deletedImages"] = jsonEncode(deletedImages);

      request.fields["title"] = content["title"];
      request.fields["description"] = content["description"];
      request.fields["postId"] = content["postId"];
      request.fields["categoryId"] = content["categoryId"];

      final response = await request.send();

      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      final json = jsonDecode(responseString);

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.data = ResponseStatus.fromJson(json);
      } else {
        apiResponse.error = handleError(response.statusCode, json);
      }
    } catch (e) {
      apiResponse.error = SOMETHING_WENT_WRONG;
    }

    return apiResponse;
  }
}
