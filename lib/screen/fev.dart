import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/api_helper.dart';
import '../models/fev_grid.dart';
import '../provider/provider_quotes.dart';

class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
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
      backgroundColor: Color(0xff7FC7D9),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.chevron_left,
              color: Color(0xffDCF2F1),
            )),
        backgroundColor: Color(0xff0F1035),
        title: const Text(
          "favorite Quotes",
          style: TextStyle(
            fontSize: 22,
            color: Color(0xffDCF2F1),
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff7FC7D9)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: FavoriteQuotesGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
