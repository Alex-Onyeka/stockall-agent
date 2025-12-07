String naira = '₦';

double referralCut = 0.2;

String formatNumber(double number) {
  if (number.toStringAsFixed(0).length == 4) {
    return "${number.toStringAsFixed(0).substring(0, 1)},${number.toStringAsFixed(0).substring(1)}";
  } else if (number.toStringAsFixed(0).length == 5) {
    return "${number.toStringAsFixed(0).substring(0, 2)},${number.toStringAsFixed(0).substring(2)}";
  } else if (number.toStringAsFixed(0).length == 6) {
    return "${number.toStringAsFixed(0).substring(0, 3)},${number.toStringAsFixed(0).substring(3)}";
  } else if (number.toStringAsFixed(0).length == 7) {
    return "${number.toStringAsFixed(0).substring(0, 1)},${number.toStringAsFixed(0).substring(1, 4)},${number.toStringAsFixed(0).substring(4)}";
  } else {
    return number.toString();
  }
}

String formatMoney(double money) {
  return "$naira${formatNumber(money)}";
}

String formatDate(DateTime date) {
  const days = [
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun',
  ];

  String dayName = days[date.weekday - 1];

  return "$dayName, ${date.day}/${date.month}/${date.year}";
}

DateTime monthStart() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
}

DateTime monthEnd() {
  final now = DateTime.now();
  return DateTime(now.year, now.month + 1, 0, 23, 59, 59);
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
  );
  return emailRegex.hasMatch(email);
}
