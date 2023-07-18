class TistoryRepository {
  // TODO chan need Tistory REST API
  List<String> testData = ["Test", "Tistory", "Data"];

  Future<List<String>> reqTistoryData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return testData;
  }
}
