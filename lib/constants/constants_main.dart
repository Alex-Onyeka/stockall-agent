String naira = '₦';

double referralCut(String role) {
  if (role == 'Employed') {
    return 0.1;
  } else {
    return 0.2;
  }
}

int storeEligibilty = 180;

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

String getMonthAndYear(DateTime month) {
  switch (month.month) {
    case 1:
      return 'January | ${month.year}';
    case 2:
      return 'February | ${month.year}';
    case 3:
      return 'March | ${month.year}';
    case 4:
      return 'April | ${month.year}';
    case 5:
      return 'May | ${month.year}';
    case 6:
      return 'June | ${month.year}';
    case 7:
      return 'July | ${month.year}';
    case 8:
      return 'August | ${month.year}';
    case 9:
      return 'September | ${month.year}';
    case 10:
      return 'October | ${month.year}';
    case 11:
      return 'November | ${month.year}';
    default:
      return 'December | ${month.year}';
  }
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

String? formatDateShort(DateTime? date) {
  return date == null
      ? null
      : "${date.day}/${date.month}/${date.year.toString().substring(2)}";
}

DateTime monthStart() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
}

DateTime secondWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 7);
}

DateTime thirdWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 14);
}

DateTime fourthWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 21);
}

DateTime monthEnd() {
  final now = DateTime.now();
  return DateTime(now.year, now.month + 1, 0, 23, 59, 59);
}

int dateDifference(DateTime date1, DateTime date2) {
  return date2.difference(date1).inDays.abs();
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
  );
  return emailRegex.hasMatch(email);
}

final double salary = 100000;
final double totalAgentTargetStores = 48;

double getAgentsSalary(int monthsRegistered) {
  var percent = (monthsRegistered / totalAgentTargetStores);
  return (salary * percent);
}
