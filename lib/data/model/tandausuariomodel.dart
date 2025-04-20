class Tandausuariomodel {
  final int id;
  final int tandaId;
  final int memeberId;
  final int numberTicket;
  final DateTime datepay;
  final String status;

  Tandausuariomodel({
    required this.id,
    required this.tandaId,
    required this.memeberId,
    required this.numberTicket,
    required this.datepay,
    required this.status,
  });
  factory Tandausuariomodel.fromJson(Map<String, dynamic> json) {
    return Tandausuariomodel(
      id: json['id'],
      tandaId: json['tandaId'],
      memeberId: json['memeberId'],
      numberTicket: json['numberTicket'],
      datepay: DateTime.parse(json['datepay']),
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tandaId': tandaId,
      'memeberId': memeberId,
      'numberTicket': numberTicket,
      'datepay': datepay.toUtc().toIso8601String(),
      'status': status,
    };
  }
}
