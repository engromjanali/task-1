// lib/
//   src/
//     domain/ ->abs
//       entities/
//       repositories/
//       usecases/

//     data/ -> impl
//       models/
//       datasources/
//       repositories/

//     presentation/ -> all with controller
//       pages/
//       widgets/
//       cubit/ or bloc/

// bool isValidPassword(String password) {
//   final regex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$');
//   bool res = regex.hasMatch(password);
//   if (res) {
//     return res;
//   } else {
//     if (password.trim().length < 6)
//       return "Password must be at least 6 characters";
//     if (password.contains(RegExp(r'[A-Z]')))
//       return "At least 1 uppercase letter";
//     if (password.trim().length < 6) return "At least 1 number";
//   }
// }
