class Orderl {
  final String id;
  final double total;
  final bool isdelivered;
  final bool ispaid;
  final int items;
  final DateTime created;

  Orderl({
    required this.id,
    required this.total,
    required this.isdelivered,
    required this.created,
    required this.items,
    required this.ispaid,
  });
}
