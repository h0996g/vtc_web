class ApiConst {
  static String baseUrl = 'https://vps.halladj.org';
  // static String baseUrl = 'http://localhost:3000';

  // Auth
  static String login = '/api/v1/admin/login';
  static String registerAdmin = '/api/v1/admin/register';
  static String registerDriver = '/api/v1/auth/register-driver';
  static String refreshToken = '/api/v1/admin/refreshToken';
  static String changePassword = '/api/v1/admin/change-password';

  // Gift Cards
  static String giftCards = '/api/v1/giftcards';
  static String giftCardByCode(String code) => '/api/v1/giftcards/$code';
  static String redeemGiftCard = '/api/v1/giftcards/redeem';

  // Wallet
  static String creditWallet = '/api/v1/wallet/credit';
  static String debitWallet = '/api/v1/wallet/debit';

  // Profile
  static String profile = '/api/v1/admin/profile';
  static String profilePhoto = '/api/v1/admin/photo';
}
