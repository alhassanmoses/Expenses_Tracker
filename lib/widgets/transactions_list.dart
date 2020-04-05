import 'package:expensestracker/models/transaction.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;
  TransactionsList(this.userTransactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5.0,
                margin: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '₵${userTransactions[index].amount}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransactions[index].date),
                    style: TextStyle(fontSize: 12.0),
                  ),
                  trailing: mediaQuery.size.width > 360
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(userTransactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(userTransactions[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}

// Old implementation of the list items, I used a card previously which wasn't
// so elegant, hence the change...
//Card(
//child: Row(
//children: <Widget>[
//Container(
//margin: EdgeInsets.symmetric(
//vertical: 10.0,
//horizontal: 15.0,
//),
//decoration: BoxDecoration(
//border: Border.all(
////                      color: Colors.orangeAccent,
//color: Theme.of(context).accentColor,
//width: 2.0,
//),
//),
//padding: EdgeInsets.all(
//10.0,
//),
//child: Text(
//'₵${userTransactions[index].amount.toStringAsFixed(2)}',
//style: TextStyle(
//fontWeight: FontWeight.bold,
//fontSize: 18.0,
//color: Theme.of(context).primaryColorDark,
//),
//),
//),
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Text(userTransactions[index].title,
//style: Theme.of(context).textTheme.title),
//Text(
//DateFormat.yMMMd()
//.format(userTransactions[index].date),
//style: TextStyle(
//fontSize: 12.0,
//color: Colors.grey,
//),
//),
//],
//)
//],
//),
//);
