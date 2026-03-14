class ApiConst {
  static String baseUrl = 'http://166.0.132.27:3000';
  // static String baseUrl = 'http://localhost:3000';

  // Auth
  static String login = '/api/v1/auth/login';
  static String registerAdmin = '/api/v1/auth/register-admin';
  static String registerDriver = '/api/v1/auth/register-driver';
  static String refreshToken = '/api/v1/auth/refresh';
  static String changePassword = '/api/v1/auth/change-password';

  // Gift Cards
  static String giftCards = '/api/v1/giftcards';
  static String giftCardByCode(String code) => '/api/v1/giftcards/$code';
  static String redeemGiftCard = '/api/v1/giftcards/redeem';

  // Wallet
  static String creditWallet = '/api/v1/wallet/credit';
  static String debitWallet = '/api/v1/wallet/debit';

  // Profile
  static String profile = '/api/v1/users/profile';
  static String profilePhoto = '/api/v1/users/photo';
}
