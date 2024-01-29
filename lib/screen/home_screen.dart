import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';
import 'package:quotes_api_app/provider/provider_quotes.dart';

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
    QuotesProvider quotesProvider = Provider.of<QuotesProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Color(0xff7FC7D9)),
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff0F1035)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' Avtar\nProfile',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xffDCF2F1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+91 70965 84269',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffDCF2F1),
                          ),
                        ),
                        Text(
                          'baradrajbha1@gmail.com',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            fontSize: 10,
                            color: Color(0xffDCF2F1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('like_screen');
                },
                leading: const Icon(
                  Icons.favorite_outline,
                  color: Color(0xff0F1035),
                ),
                title: const Text(
                  'Favorite Quotes',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff0F1035),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff7FC7D9),
      appBar: AppBar(
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Navigator.of(context).pushNamed('fev');
            },
            child: const Icon(
              Icons.favorite_outline,
              color: Color(0xffDCF2F1),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Color(0xff0F1035),
        title: const Text(
          "Quotes API",
          style: TextStyle(
            fontSize: 22,
            color: Color(0xffDCF2F1),
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
                                (e) => InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, 'detail',
                                      arguments: e),
                                  child: Card(
                                    color: Color(0xff365486),
                                    elevation: 10,
                                    shadowColor: Colors.indigoAccent,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
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
                                                fontSize: 25,
                                                color: Color(0xffDCF2F1),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            e.content,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xffDCF2F1),
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.authorSlug,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xffDCF2F1),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(50),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  onTap: () {
                                                    quotesProvider
                                                        .addToFavorites(e.id);
                                                    final snackBar = SnackBar(
                                                      /// need to set following properties for best effect of awesome_snackbar_content
                                                      elevation: 0,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content:
                                                          AwesomeSnackbarContent(
                                                        title:
                                                            'Congrachulation!',
                                                        message:
                                                            'congrachulation your quotes add on favorite Qoutes ',
                                                        contentType:
                                                            ContentType.success,
                                                      ),
                                                    );

                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(snackBar);
                                                  },
                                                  child: const Icon(
                                                    Icons.favorite_outline,
                                                    color: Color(0xffDCF2F1),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
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
