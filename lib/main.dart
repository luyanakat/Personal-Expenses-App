import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart'; for WidgetsFlutterBindings
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/add_new_transacion.dart';
import './widgets/chart.dart';

void main() {
  // A Feature to best Reponstive: Lock Landscape mode :))
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
      ),
      title: 'Second App',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Transaction map
  final List<Transaction> _transaction = [
    // Adding Fake Data here
  ];

  bool _showChart = false; // for Switch

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  //  Fuction to add new Transaction
  void _addNewTransaction(String title, double amount, DateTime date) {
    var newTx = Transaction(
      title,
      amount,
      date,
      DateTime.now().toString(),
    );
    setState(() {
      // Just remember to set State to re-render UI
      _transaction.add(newTx);
    });
    Navigator.of(context).pop();
  }

  // Show Add new Transaction Modal
  void _showAddNewTxBottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return AddNewTransaction(_addNewTransaction);
        });
  }

  // Function to delete Transacation
  void deleteTX(String id) {
    setState(() {
      _transaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _showAddNewTxBottom(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            backgroundColor: Theme.of(context).primaryColor,
          ) as PreferredSizeWidget;
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: isLandscape == true
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Switch.adaptive(
                        activeColor: Theme.of(context).primaryColor,
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        },
                      ),
                    ],
                  ),
                  _showChart == true
                      ? SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.6, // 0,25
                          child: Chart(_recentTransaction))
                      : SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.6, //0.75
                          child: TransactionList(_transaction, deleteTX),
                        ),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.25, // 0,25
                      child: Chart(_recentTransaction)),
                  SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.75, //0.75
                    child: TransactionList(_transaction, deleteTX),
                  ),
                ],
              ),
      ),
    );
    return MaterialApp(
      home: Platform.isIOS
          ? CupertinoPageScaffold(
              child: pageBody,
              navigationBar: appBar as ObstructingPreferredSizeWidget,
            )
          : Scaffold(
              appBar: appBar,
              body: pageBody,
              floatingActionButton: Platform.isIOS
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () => _showAddNewTxBottom(context),
                      child: const Icon(Icons.add),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
    );
  }
}
