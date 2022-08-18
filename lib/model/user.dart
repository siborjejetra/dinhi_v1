class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String birthday;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.birthday,
    required this.isDarkMode
  });
}