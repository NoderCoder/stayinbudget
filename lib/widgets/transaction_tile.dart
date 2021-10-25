import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String transactionTitle;
  final String transactionDate;
  final String transactionAmount;

  TransactionTile(
      this.transactionTitle, this.transactionDate, this.transactionAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        foregroundColor: Colors.grey[700],
                        child: const Icon(
                          Icons.import_export_rounded,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionTitle,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(transactionDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                  )),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        transactionAmount,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.amber[300],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("+3%",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
