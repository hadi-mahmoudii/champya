class Urls {
  static const baseUrl = 'https://app.champya-dev.ir/api/v1';
  // static const domain = 'https://www.kamancable.ir';

  static const login = '$baseUrl/auth/login';
  static const forgetPass = '$baseUrl/auth/forget-password';
  static const submitCode = '$baseUrl/auth/verify-email';
  static const resendCode = '$baseUrl/auth/resend-email-verification-code';

  static const register = '$baseUrl/auth/register';
  static const changePass = '$baseUrl/auth/change-password';
  static logout(String phone) => '$baseUrl/auth/logout';
  static const user = '$baseUrl/user';
  static const home = '$baseUrl/application/home';

  static const getCategories = '$baseUrl/sport-categories';
  static getCategoryProgramData(String id, String page) =>
      '$baseUrl/courses?filters[sport_category_id]=$id&page=$page';
  static getCategoryWorkoutData(String id, String page) =>
      '$baseUrl/workouts?filters[sport_category_id]=$id&page=$page';

  static getProgramDatas(String id) => '$baseUrl/courses/$id';
  static startProgram(String id) => '$baseUrl/courses/user/join/$id';

  static getProducts(String page) => '$baseUrl/products?page=$page';
  static getProductsByName(String name, String page) =>
      '$baseUrl/get-products-mobile?name=$name&page=$page';

  static getProduct(String id) => '$baseUrl/get-products-mobile/$id';

  static const getMyPrograms = '$baseUrl/my-courses';
  static getMyProgram(String id) => '$baseUrl/my-courses/$id';

  static getSerieDetails(String id) => '$baseUrl/get-course-series/$id';

  static const getMyCustomPrograms = '$baseUrl/my-own-courses';
  static getMyCustomProgram(String id) => '$baseUrl/my-own-courses/$id';

  static getMentorInfo(String id) => '$baseUrl/courses/$id/trainer-information';

  static const createProgram = '$baseUrl/courses';
  static updateProgram(String id) => '$baseUrl/courses/$id';
  static removeSerieFromCustomProgram(String id) =>
      '$baseUrl/courses/series/$id';
  static stopProgram(String id) => '$baseUrl/courses/$id/stop-doing-course';

  static createSerie(String id) => '$baseUrl/courses/$id/series';
  static addWorkoutToSerie(String serieId, String workoutId) =>
      '$baseUrl/course/user/series/$serieId/workout/$workoutId';

  static dayProgramSerieDone(String programId, String serieId) =>
      '$baseUrl/courses-log/course/$programId/series/$serieId';

  static getComments(String type, String id) =>
      '$baseUrl/comments?commentable_type=$type&commentable_id=$id';
  static const sendComment = '$baseUrl/comments';
  static const getBookmarks = '$baseUrl/bookmarks/workout';
  static const addBookmark = '$baseUrl/bookmarks';
  static deleteBookmark(String id) => '$baseUrl/bookmarks/$id';
  static const getSections = '$baseUrl/app-sections/home';
}
