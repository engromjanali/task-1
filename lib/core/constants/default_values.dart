// ⚙️ PDefaultValues
// Holds default constant values used across the app.
// 🧰 Includes:
// - Default texts for missing data (name, image, fee)
// - File type validation list
// - Character limits for inputs
// - Phone number length, DOB limits, etc.


class PDefaultValues {
  static const String noFee = "N/A";
  static const String noName = "N/A";
  static const int phoneNumberLength = 11;
  static const int textMaxLength = 100;
  static const int textAreaMaxLength = 1000;
  static const List<String> allowedFileTypes = ['jpg', 'pdf', 'png'];
  static const int minDOBDate = 1900;
  static const int passwordMinLength = 8;
}
