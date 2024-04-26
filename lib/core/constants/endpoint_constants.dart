class EndPointConstants {
  static const String _baseUrl =
      "http://salahelden18-001-site1.atempurl.com/api";

  // account
  static const String accountBase = "$_baseUrl/Account";
  static const String login = '$accountBase/User/Login';
  static const String signup = '$accountBase/User/Signup';
  static const String verify = '$accountBase/User/VerifyOtp';

  // address
  static const String addressBase = "$_baseUrl/Address";

  // branch
  static const String branchBase = "$_baseUrl/Branch";
  static const String nearBranches = "$_baseUrl/Branch/Near-Branch";

  // banners
  static const String bannersBase = "$_baseUrl/Banners";

  // favorite
  static const String baseFavorite = "$_baseUrl/FavoriteProduct";

  // products
}
