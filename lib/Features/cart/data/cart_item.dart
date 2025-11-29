import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class CartItem extends HiveObject {
  @HiveField(0) final int productId;
  @HiveField(1) final String title;
  @HiveField(2) final double price;
  @HiveField(3) int quantity;
  @HiveField(4) final String thumbnail;

  CartItem({required this.productId, required this.title, required this.price, required this.quantity, required this.thumbnail});
}

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override final int typeId = 2;
  @override CartItem read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int,dynamic>{ for (int i=0;i<n;i++) reader.readByte(): reader.read() };
    return CartItem(
      productId: f[0] as int,
      title: f[1] as String,
      price: f[2] as double,
      quantity: f[3] as int,
      thumbnail: f[4] as String,
    );
  }
  @override void write(BinaryWriter writer, CartItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)..write(obj.productId)
      ..writeByte(1)..write(obj.title)
      ..writeByte(2)..write(obj.price)
      ..writeByte(3)..write(obj.quantity)
      ..writeByte(4)..write(obj.thumbnail);
  }
}