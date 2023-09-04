import 'package:graphql/client.dart';
import 'models/ship_model.dart';
import 'package:flutter_graphql_spacex/api/queries/queries.dart' as queries;

class GetJobsRequestFailure implements Exception {}

class ShipsApiClient{
  const ShipsApiClient({required this.graphQLClient});

  factory ShipsApiClient.create(){
    final httpLink = HttpLink("https://spacex-production.up.railway.app/");
    final link = Link.from([httpLink]);

    return ShipsApiClient(graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link));
  }

  final GraphQLClient graphQLClient;

  Future<List<ShipModel>> getShips()async{
    final result = await graphQLClient.query(
        QueryOptions(document: gql(queries.getShips))
    );

    if (result.hasException) throw GetJobsRequestFailure();
    return (result.data?['ships'] as List?)
        ?.map((dynamic e) => ShipModel.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [];
  }
}