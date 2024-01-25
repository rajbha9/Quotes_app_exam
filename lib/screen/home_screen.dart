import 'package:flutter/material.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    await APIHelper.apiHelper.fetchedQuote().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7FC7D9),
      appBar: AppBar(
        backgroundColor: Color(0xff0F1035),
        title: const Text(
          "Quotes API",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: FutureBuilder(
                future: APIHelper.apiHelper.fetchedQuote(),
                builder: (context, snapshot) {
                  List<Quote>? data;
                  (snapshot.hasError)
                      ? print(snapshot.error)
                      : snapshot.hasData
                          ? data = snapshot.data
                          : const CircularProgressIndicator();

                  return (data == null)
                      ? Container()
                      : GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 1,
                                  childAspectRatio: 5 / 2.5),
                          children: data
                              .map(
                                (e) => Card(
                                  color: Color(0xff365486),
                                  elevation: 10,
                                  shadowColor: Colors.indigoAccent,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      // color: Color(0xff365486),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.author,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xffDCF2F1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          e.content,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Color(0xffDCF2F1),
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Text(
                                            //   e.authorSlug,
                                            //   style: const TextStyle(
                                            //       fontSize: 18,
                                            //       fontWeight: FontWeight.w100),
                                            // ),
                                            FloatingActionButton(
                                              mini: true,
                                              onPressed: () {},
                                              child: const Icon(
                                                  Icons.favorite_outline),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
