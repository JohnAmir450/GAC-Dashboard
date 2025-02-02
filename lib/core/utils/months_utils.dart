class MonthUtils {
  static final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static String convertMonthToArabic(String month) {
    switch (month) {
      case 'January': return 'يناير';
      case 'February': return 'فبراير';
      case 'March': return 'مارس';
      case 'April': return 'أبريل';
      case 'May': return 'مايو';
      case 'June': return 'يونيو';
      case 'July': return 'يوليو';
      case 'August': return 'أغسطس';
      case 'September': return 'سبتمبر';
      case 'October': return 'أكتوبر';
      case 'November': return 'نوفمبر';
      case 'December': return 'ديسمبر';
      default: return month; // Return the original month if no match is found
    }
  }
}
