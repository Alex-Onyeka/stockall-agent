bool isToday(DateTime date) {
  final now = DateTime.now();

  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

bool isYesterday(DateTime date) {
  final yesterday = DateTime.now().subtract(
    const Duration(days: 1),
  );

  return date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day;
}

bool isThisWeek(DateTime date) {
  final now = DateTime.now();

  // Monday = 1, Sunday = 7
  final startOfWeek = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: now.weekday - 1));

  final endOfWeek = startOfWeek.add(
    const Duration(days: 7),
  );

  return !date.isBefore(startOfWeek) &&
      date.isBefore(endOfWeek);
}

bool isLastWeek(DateTime date) {
  final now = DateTime.now();

  final startOfThisWeek = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: now.weekday - 1));

  final startOfLastWeek = startOfThisWeek.subtract(
    const Duration(days: 7),
  );

  return !date.isBefore(startOfLastWeek) &&
      date.isBefore(startOfThisWeek);
}

bool isThisMonth(DateTime date) {
  final now = DateTime.now();

  return date.year == now.year && date.month == now.month;
}

bool isLastMonth(DateTime date) {
  final now = DateTime.now();

  final lastMonth = DateTime(now.year, now.month - 1);

  return date.year == lastMonth.year &&
      date.month == lastMonth.month;
}

bool isThisYear(DateTime date) {
  return date.year == DateTime.now().year;
}

bool isLastYear(DateTime date) {
  return date.year == DateTime.now().year - 1;
}
