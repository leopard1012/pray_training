class Params {
  String? pray;
  String? param1;
  String? param2;
  String? param3;
  String? param4;
  String? param5;

  Params({required this.pray, this.param1, this.param2, this.param3, this.param4, this.param5});

  Map<String, dynamic> toMap() {
    return {
      'pray': pray,
      'param1': param1,
      'param2': param2,
      'param3': param3,
      'param4': param4,
      'param5': param5,
    };
  }
}