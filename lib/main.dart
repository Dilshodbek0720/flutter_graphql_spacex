import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_spacex/api/ships_api.dart';
import 'package:flutter_graphql_spacex/blocs/ships/ships_bloc.dart';
import 'package:flutter_graphql_spacex/blocs/ships/ships_event.dart';
import 'package:flutter_graphql_spacex/ui/ships/ships_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MainApp(
    jobsApiClient: ShipsApiClient.create(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.jobsApiClient});

  final ShipsApiClient jobsApiClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ShipsBloc(jobsApiClient: jobsApiClient)
          ..add(
            ShipsFetchStarted(),
          ),
      )
    ], child: GraphQLProvider(
      client: ValueNotifier(ShipsApiClient.create().graphQLClient),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ShipsScreen(),
      ),
    ),
    );
  }
}
