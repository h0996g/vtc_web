class ApiConst {
  static String baseUrl = 'https://vps.halladj.org';
  // static String baseUrl = 'http://localhost:3000';

  // Base paths
  static const String apiV1 = '/api/v1';
  static const String adminAuth = '$apiV1/admin';
  static const String adminProfile = '$apiV1/admin';

  // Admin Auth
  static String login = '$adminAuth/login';
  static String registerAdmin = '$apiV1/auth/register-admin';
  static String registerDriver = '$apiV1/auth/register-driver';
  static String refreshToken = '$adminAuth/refreshToken';
  static String forgotPassword = '$adminAuth/forgot-password';
  static String resetPassword = '$adminAuth/reset-password';
  static String changePassword = '$adminAuth/change-password';

  // Gift Cards
  static String giftCards = '$apiV1/giftcards';
  static String giftCardByCode(String code) => '$apiV1/giftcards/$code';
  static String redeemGiftCard = '$apiV1/giftcards/redeem';

  // Wallet
  static String creditWallet = '$apiV1/wallet/credit';
  static String debitWallet = '$apiV1/wallet/debit';

  // Profile
  static String profile = '$adminProfile/profile';
  static String profilePhoto = '$adminProfile/photo';
}
