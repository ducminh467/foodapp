

import 'product_model.dart';


class History{

  History({
    required this.tenNguoiMua,
    required this.emailNguoiMua,
    required this.ngay,
    required this.products,
    this.total
});

  final String ngay, tenNguoiMua, emailNguoiMua;
  final String? total;
  final List<Product> products;


  List<Map<String, dynamic>> toMapList(){

    return products.map((e) => {
      "url": e.url,
      "id": e.id,
      "soluong": e.soluong,
      "price": e.price,
      "name": e.name,
      "loai": e.loai,
      "nguoidang": e.nguoidang,
      "diachi": e.diachi
    }).toList();
  }


}