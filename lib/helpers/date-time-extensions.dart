extension DateTimeExtensions on DateTime {
  String getDate() {
    return this.day.toString() +
        '.' +
        this.month.toString() +
        '.' +
        this.year.toString();
  }

  String getTime() {
    final _scnd = (this.minute < 10)
        ? ('0' + this.minute.toString())
        : this.minute.toString();
    final _frst =
        (this.hour < 10) ? ('0' + this.hour.toString()) : this.hour.toString();
    return _frst + ':' + _scnd;
  }
}
