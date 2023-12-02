
import 'Condition.dart';
class Current {
  final double temp;

  final Condition condition;
  // ... (other properties)

  Current({

    required this.temp,

    required this.condition,

  });

  factory Current.fromJson(dynamic json) {
    return Current(

      temp: json['temp_c'].toDouble(),

      condition: Condition.fromJson(json['condition']),

    );
  }
}