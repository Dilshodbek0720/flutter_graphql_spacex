import '../../utils/export_library.dart';

class ShipsScreen extends StatelessWidget {
  const ShipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ships Screen'),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const ShipsGraphqlScreen();
            }));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: BlocBuilder<ShipsBloc, ShipsState>(
          builder: (context, state) {
            if (state is ShipsLoadInProgress) {
              return const CircularProgressIndicator();
            }
            if (state is ShipsLoadSuccess) {
              return ListView.builder(
                itemCount: state.ships.length,
                itemBuilder: (context, index) {
                  final ship = state.ships[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      border: Border.all(width: 1, color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.tealAccent,
                          blurRadius: 1,
                          spreadRadius: 1
                        )
                      ]
                    ),
                    child: ListTile(
                      key: Key(ship.model),
                      leading: const Icon(Icons.location_city),
                      title: Text(ship.name),
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
                      subtitle: Text(ship.yearBuilt.toString()),
                    ),
                  );
                },
              );
            }
            return const Text('Nimadur xatolik yuz berdi!');
          },
        ),
      ),
    );
  }
}