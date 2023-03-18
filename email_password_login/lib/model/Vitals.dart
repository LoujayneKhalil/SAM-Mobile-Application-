// ignore_for_file: non_constant_identifier_names, file_names

class Vitals {
  final Object HRate;
  final Object SpO2;
  final Object Temp;
  Vitals({required this.HRate, required this.SpO2, required this.Temp});

  factory Vitals.fromRTDB(Map<String, dynamic> data) {
    return Vitals(
        HRate: data['HeartRate'],
        SpO2: data['SpO2'],
        Temp: data['Temperature']);
  }
  String HRtext() {
    return ' $HRate';
  }

  String Spo2text() {
    return ' $SpO2';
  }

  String Temptext() {
    return ' $Temp';
  }
}
