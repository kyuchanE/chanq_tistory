import 'dart:convert';
import 'package:chanq_tistory_project/components/config.dart';
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
}
