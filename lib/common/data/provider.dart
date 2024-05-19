import 'package:wallet_watch/common/enum/item_state.dart';

class Paylater {
  final String id;
  final String name;
  final ItemState state;

  Paylater({required this.id, required this.name, required this.state});
}

final List<Paylater> paylaterList = [
  Paylater(id: "1", name: "Akulaku", state: ItemState.akulaku),
  Paylater(id: "2", name: "Kredivo", state: ItemState.kredivo),
  Paylater(id: "3", name: "Shopee", state: ItemState.shopee),
];
