class OrderDetail {
  final String id;
  final int quantity;
  final String productname;
  final double productprice;
  final String url;
  final double subtotal;

  OrderDetail({
    required this.id,
    required this.quantity,
    required this.productname,
    required this.productprice,
    required this.url,
    required this.subtotal,
  });
}
