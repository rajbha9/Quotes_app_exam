import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';

import '../provider/provider_quotes.dart';

class FavoriteQuotesGrid extends StatelessWidget {
  const FavoriteQuotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider = Provider.of<QuotesProvider>(context);

    return FutureBuilder(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 5 / 2.5),
                children: data
                    .where((quote) =>
                        quotesProvider.favoriteQuotes.contains(quote.id))
                    .map(
                      (e) => Card(
                        color: Color(0xff365486),
                        elevation: 3,
                        shadowColor: Colors.indigoAccent,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xff365486),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const Spacer(),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(50),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {
                                        quotesProvider.removeFromFavorites(e.id);
                                        final snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Remove!',
                                            message:
                                                'Remove your quotes add on favorite Qoutes ',
                                            contentType: ContentType.failure,
                                          ),
                                        );

                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
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
    );
  }
}
