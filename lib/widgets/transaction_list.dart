import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Transactionlist extends StatelessWidget {
  final List transactions;
  final Function deletetx;

  Transactionlist(this.transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No Transactions added yet! ',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/empty.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text('Rs ${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMMEEEEd()
                        .format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deletetx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
