class Tandamodel {
  final int id;
  final String alias;
  final double poolAmount;
  final String period;
  final int members;
  final DateTime startDate;
  final DateTime endDate;
  final double totalEndPool;
  final int creationUserId;
  final String usercreation;

  Tandamodel({
    required this.id,
    required this.alias,
    required this.poolAmount,
    required this.period,
    required this.members,
    required this.startDate,
    required this.endDate,
    required this.totalEndPool,
    required this.creationUserId,
    required this.usercreation,
  });
  factory Tandamodel.fromJson(Map<String, dynamic> json) {
    return Tandamodel(
      id: json['id'],
      alias: json['alias'],
      poolAmount: json['poolAmount'],
      period: json['period'],
      members: json['members'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      totalEndPool: json['totalEndPool'],
      creationUserId: json['creationUserId'],
      usercreation: json['userCreation'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alias': alias,
      'poolAmount': poolAmount,
      'period': period,
      'members': members,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'totalEndPool': totalEndPool,
      'creationUserId': creationUserId,
      'usercreation': usercreation,
    };
  }
}
