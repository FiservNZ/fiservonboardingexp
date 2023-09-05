class Achievement {
  final int levelRequired;
  final String title;
  final String description;
  bool isUnlocked;

  Achievement({
    required this.levelRequired,
    required this.title,
    required this.description,
    this.isUnlocked = false,
  });
}
