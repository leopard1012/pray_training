class Params {
  String? pray;
  String? param1;
  String? param2;
  String? param3;

  Params({required this.pray, this.param1, this.param2, this.param3});

  Map<String, dynamic> toMap() {
    return {
      'pray': pray,
      'param1': param1,
      'param2': param2,
      'param3': param3,
    };
  }
}