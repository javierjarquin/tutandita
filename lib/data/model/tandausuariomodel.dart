class TandaUsuarioModel {
  final int id;
  final int tandaId;
  final int memberId;
  final String name;
  final String phone;
  final int numberTicket;
  final DateTime datepay;
  final String status;

  TandaUsuarioModel({
    required this.id,
    required this.tandaId,
    required this.memberId,
    required this.name,
    required this.phone,
    required this.numberTicket,
    required this.datepay,
    required this.status,
  });

  factory TandaUsuarioModel.fromJson(Map<String, dynamic> json) {
    return TandaUsuarioModel(
      id: json['id'],
      tandaId: json['tandaId'],
      memberId: json['memberId'],
      name: json['name'],
      phone: json['phone'],
      numberTicket: json['numberTicket'],
      datepay: DateTime.parse(json['datePay']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tandaId': tandaId,
      'memberId': memberId, // corregido
      'name': name,
      'phone': phone,
      'numberTicket': numberTicket,
      'datepay': datepay.toIso8601String(),
      'status': status,
    };
  }
}
