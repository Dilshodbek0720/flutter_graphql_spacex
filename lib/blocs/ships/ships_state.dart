import 'package:flutter_graphql_spacex/api/models/ship_model.dart';

abstract class ShipsState {}

class ShipsLoadInProgress extends ShipsState {}

class ShipsLoadSuccess extends ShipsState {
  ShipsLoadSuccess(this.ships);

  final List<ShipModel> ships;
}

class ShipsLoadFailure extends ShipsState {}