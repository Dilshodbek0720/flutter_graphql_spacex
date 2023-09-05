import '../../utils/export_library.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShipsGraphqlScreen extends StatefulWidget {
  const ShipsGraphqlScreen({super.key});

  @override
  State<ShipsGraphqlScreen> createState() => _ShipsGraphqlScreenState();
}

class _ShipsGraphqlScreenState extends State<ShipsGraphqlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ships Graphql Screen"),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Query(
          options: QueryOptions(
            document: gql(getShips),
          ),
          builder: (QueryResult result,  {VoidCallback? refetch, FetchMore? fetchMore}){
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<ShipModel> ships = (result.data?['ships'] as List?)
                ?.map((dynamic e) => ShipModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
                [];
            if (ships.isEmpty) {
              return const Text('No repositories');
            }
            return ListView.builder(
              itemCount: ships.length,
              itemBuilder: (context, index) {
                final ship = ships[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      border: Border.all(width: 1, color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 1
                        )
                      ]
                  ),
                  child: ListTile(
                    key: Key(ship.model),
                    leading: const Icon(Icons.location_city, color: Colors.white,),
                    title: Text(ship.name, style: const TextStyle(color: Colors.white),),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: ship.image,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => SizedBox(height: 55, width: 55, child: Lottie.asset("assets/lottie/image_error.json"),),
                      ),
                    ),
                    subtitle: Text(ship.yearBuilt.toString(),  style: TextStyle(color: Colors.white.withOpacity(0.5)),),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
