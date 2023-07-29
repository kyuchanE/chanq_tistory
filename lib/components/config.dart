class CQConfig {
  // Tistory REST API Config Data
  static const accessTokenTistory = '';
  static const nameTistory = '';
  static const baseUrlTistory = 'www.tistory.com';
  static const postListTistory = '/apis/post/list';

  Uri getPostListTistoryUri() => Uri.parse(
      "${baseUrlTistory}${postListTistory}?access_token=${accessTokenTistory}&output=json&blogName=${nameTistory}");

  static const baseUrlRandomUser = 'https://randomuser.me/api';
  static const resultsCount = '/?results';

  Uri getRandomUserUri(int cnt) =>
      Uri.parse('$baseUrlRandomUser$resultsCount=$cnt');
}
