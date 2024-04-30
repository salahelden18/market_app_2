class EndPointConstants {
  static const String _baseUrl =
      "http://salahelden18-001-site1.atempurl.com/api";

  // account
  static const String accountBase = "$_baseUrl/Account";
  static const String login = '$accountBase/User/Login';
  static const String signup = '$accountBase/User/Signup';
  static const String verify = '$accountBase/User/VerifyOtp';
  static const String forgot = '$accountBase/User/forgotPassword';

  static String configFCM(String fcmToken) =>
      '$accountBase/configFCM/$fcmToken';

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

  // basket
  static const String basketBase = '$_baseUrl/Basket';

  // countries
  static const String countryBase = "$_baseUrl/Countries";

  // cities
  static const String cityBase = "$_baseUrl/Cities";

  // district
  static const String districtBase = "$_baseUrl/Districts";

  // subDistricts
  static const String subDistrictBase = "$_baseUrl/SubDistricts";

  // payments
  static const String paymentBase = "$_baseUrl/BranchPaymentMethod/Branch";

  // orders
  static const String orderBase = "$_baseUrl/Order";

  // user
  static const String userBase = "$_baseUrl/User";
}
