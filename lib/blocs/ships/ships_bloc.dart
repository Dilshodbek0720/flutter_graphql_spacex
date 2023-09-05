import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_graphql_spacex/api/ships_api.dart';
import 'package:flutter_graphql_spacex/blocs/ships/ships_event.dart';
import 'package:flutter_graphql_spacex/blocs/ships/ships_state.dart';

class ShipsBloc extends Bloc<ShipsEvent, ShipsState>{
  ShipsBloc({required ShipsApiClient jobsApiClient})
  : _jobsApiClient = jobsApiClient,
  super(ShipsLoadInProgress()){
    on<ShipsFetchStarted>(_onShipsFetchStarted);
  }

  final ShipsApiClient _jobsApiClient;

  Future<void> _onShipsFetchStarted(
      ShipsFetchStarted event,
      Emitter<ShipsState> emit,
      ) async {
    emit(ShipsLoadInProgress());
    try {
      final ships = await _jobsApiClient.getShips();
      // final singleCountry = await _jobsApiClient.getCountryById("UZ");
      // print("COUNTRY NAME:${singleCountry.name}");
      emit(ShipsLoadSuccess(ships));
    } catch (error) {
      debugPrint("ERRROR:$error");
      emit(ShipsLoadFailure());
    }
  }

}