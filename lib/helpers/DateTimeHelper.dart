Time getNextAlarmTime() {
  DateTime dateTime = DateTime.now();
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  int second = dateTime.second;

  //9AM is hardCoded
  int expectedHour = 8;
  int expectedMinute = 0;
  int expectedSecond = 0;

  int x;
  int y;
  int z;

  if (hour > expectedHour) {
    x = 24 - hour + 8 - 1;
  } else {
    x = expectedHour - hour;
  }
  if (minute > expectedMinute) {
    y = 60 - minute;
  } else
    y = expectedMinute - minute;

  if (second > expectedSecond) {
    z = 60 - second;
  } else {
    z = expectedSecond - second;
  }

  print("Hours: $x Minutes: $y Seconds: $z");
  return new Time(x, y, z);
}

class Time {
  int hours;
  int minutes;
  int seconds;
  Time(this.hours, this.minutes, this.seconds);
}
