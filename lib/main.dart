import 'package:graphql_flutter/graphql_flutter.dart';
import 'utils/export_library.dart';

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
