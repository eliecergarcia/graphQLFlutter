import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ivoy/model/country.dart';

void main() {
  final HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );

  var app = GraphQLProvider(
    client: client,
    child: const AppState(),
  );
  runApp(app);
  // runApp(const MyApp());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  List<Country> countries = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Query(
          options: QueryOptions(
            document: gql(countryGraphQL),
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final country = result.data?["countries"];
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Countries',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: country.length,
                      itemBuilder: (_, index) {
                        //Country.fromJson(country[index]);
                        return Card(
                          child: ListTile(
                            title: Text(country[index]['name']),
                            subtitle: country[index]['capital'] != null
                                ? Text(country[index]['capital'])
                                : const Text(''),
                            onTap: () {
                              final dialog = AlertDialog(
                                title: Text(country[index]['name']),
                                content: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Capital: '),
                                          country[index]['capital'] != null
                                              ? Text(country[index]['capital'])
                                              : const Text(''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Native: '),
                                          country[index]['native'] != null
                                              ? Text(country[index]['native'])
                                              : const Text(''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Emoji: '),
                                          country[index]['emoji'] != null
                                              ? Text(country[index]['emoji'])
                                              : const Text(''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Currency: '),
                                          country[index]['currency'] != null
                                              ? Text(country[index]['currency'])
                                              : const Text(''),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Ok"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (_) => dialog,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(),
      ),
    );
  }
}

const countryGraphQL = """
                    query {
  countries {
    name
    native
    capital
    emoji
    currency
    languages {
      code
      name
    }
  }

}
                  """;
