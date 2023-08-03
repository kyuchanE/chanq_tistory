import 'dart:convert';
import 'package:chanq_tistory_project/components/config.dart';
import '../model/random_user_data.dart';
import '../model/tistory_post_list_data.dart';
import 'package:http/http.dart' as http;

class TistoryRepository {
  // TODO chan need Tistory REST API
  List<String> testData = ["Test", "Tistory", "Data"];

  Future<List<String>> reqTistoryData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return testData;
  }

  Future<TistoryPostListData> reqTistoryPostList() async {
    TistoryPostListData postListData = TistoryPostListData();

    final response = await http.get(CQConfig().getPostListTistoryUri());
    if (response.statusCode == 200) {
      postListData = jsonDecode(response.body);
    }

    return postListData;
  }

  Future<RandomUserData> reqRandomUserData() async {
    RandomUserData data = RandomUserData(null, null);
    await Future.delayed(Duration(milliseconds: 2000));
    final response = await http.get(CQConfig().getRandomUserUri(15));
    if (response.statusCode == 200) {
      data = RandomUserData.fromJson(jsonDecode(response.body));
    }

    return data;
  }
}
