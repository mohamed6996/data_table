import 'package:data_table/model/json_response.dart';
import 'package:data_table/model/client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactLocations extends StatefulWidget {
  @override
  _ContactLocationsState createState() => _ContactLocationsState();
}

class _ContactLocationsState extends State<ContactLocations> {
  List<Client> clients = [];
  List<TableRow> _tableRows = [];

  final BoxDecoration _header = BoxDecoration(color: Colors.grey);
  final BoxDecoration _even = BoxDecoration(color: Colors.amberAccent);
  final BoxDecoration _odd = BoxDecoration(color: Colors.orange);

  bool isSortedByRating = false;
  bool isSortedByDistance = false;
  bool isSortedByMaxPrice = false;
  bool isSortedByFee = false;

  Future<List<Client>> _getClients() async {
    if (clients.length == 0) { // don`t make a network request if clients already exist
      final res = await http.get(
          "https://paul-hammant.github.io/json_doc/contact_locations.json");

      List<Location> locations =
          BaseResponse.fromJson(jsonDecode(res.body)).locations;

      clients = new List.generate(locations.length, (int index) {
        return Client(
            locations[index].contact.name,
            locations[index].contact.category,
            locations[index].rating,
            locations[index].distance,
            locations[index].maximum_withdrawal.amount.toInt(),
            locations[index].maximum_withdrawal.currency,
            locations[index].fee.toInt());
      });

      return clients;
    } else {
      return clients;
    }
  }

  Future<List<TableRow>> _prepareRows() async {
    await _getClients();

    _tableRows = [
      // prepare column row first
      TableRow(decoration: _header, children: _headerChildren()),
    ];

    // prepare rows and then add them to be below the column row
    List<TableRow> _rows = new List.generate(clients.length, (int index) {
      return TableRow(
          decoration: index.isEven ? _even : _odd,
          children: _rowChildren(clients, index));
    });

    _tableRows.addAll(_rows);

    return _tableRows;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _prepareRows(),
      builder: (context, AsyncSnapshot<List<TableRow>> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              columnWidths: _columnsWidth,
              defaultColumnWidth: FlexColumnWidth(1.0),
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              border: TableBorder.all(color: Colors.black),
              children: snapshot.data,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Map<int, TableColumnWidth> _columnsWidth = {
    0: FlexColumnWidth(2.0),
    1: FlexColumnWidth(1.5),
    2: FlexColumnWidth(2.0),
    3: FlexColumnWidth(2.0),
    4: FlexColumnWidth(1.1),
  };

  _toggleRateSorting() {
    setState(() {
      if (isSortedByRating) {
        clients.sort((a, b) => a.rating.toInt() < b.rating.toInt() ? 1 : 0);
        isSortedByRating = false;
      } else {
        clients.sort((a, b) => a.rating.toInt() > b.rating.toInt() ? 1 : 0);
        isSortedByRating = true;
      }
    });
  }

  _toggleDistanceSorting() {
    setState(() {
      if (isSortedByDistance) {
        clients.sort((a, b) => a.distance < b.distance ? 1 : 0);
        isSortedByDistance = false;
      } else {
        clients.sort((a, b) => a.distance > b.distance ? 1 : 0);
        isSortedByDistance = true;
      }
    });
  }

  _toggleMaxPriceSorting() {
    setState(() {
      if (isSortedByMaxPrice) {
        clients.sort((a, b) => a.max_price < b.max_price ? 1 : 0);
        isSortedByMaxPrice = false;
      } else {
        clients.sort((a, b) => a.max_price > b.max_price ? 1 : 0);
        isSortedByMaxPrice = true;
      }
    });
  }

  _toggleFeeSorting() {
    setState(() {
      if (isSortedByFee) {
        clients.sort((a, b) => a.fee < b.fee ? 1 : 0);
        isSortedByFee = false;
      } else {
        clients.sort((a, b) => a.fee > b.fee ? 1 : 0);
        isSortedByFee = true;
      }
    });
  }

  List<Widget> _rowChildren(List<Client> persons, int index) {
    return [
      Center(
          child: GestureDetector(
            onTap: () {
              //todo write your logic here
              print("you clicked ${persons[index].person_name}");
            },
            child: Column(
              children: <Widget>[
                Text("${persons[index].person_name}",
                    style: TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline)),
                Text("${persons[index].category}"),
              ],
            ),
          )),
      Center(
          child: Container(
            child: Text("${persons[index].rating}%"),
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          )),
      Center(
          child: Container(
            child: Text("${persons[index].distance}m"),
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          )),
      Center(
          child: Container(
            child: Text("${persons[index].currency}${persons[index].max_price}"),
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          )),
      Center(
          child: Container(
            child: Text("${persons[index].fee}%"),
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          )),
    ];
  }



  List<Widget> _headerChildren() {
    return [
      _columnHeader("Person", isSorted: false, isPerson: true),
      _columnHeader("Rating", isSorted: isSortedByRating),
      _columnHeader("Distance", isSorted: isSortedByDistance),
      _columnHeader("Max Price", isSorted: isSortedByMaxPrice),
      _columnHeader("Fee", isSorted: isSortedByFee),
    ];
  }

  Widget _columnHeader(String columnName,
      {bool isSorted, bool isPerson = false}) {
    return GestureDetector(
      onTap: () {
        switch (columnName) {
          case "Rating":
            _toggleRateSorting();
            break;
          case "Distance":
            _toggleDistanceSorting();
            break;
          case "Max Price":
            _toggleMaxPriceSorting();
            break;
          case "Fee":
            _toggleFeeSorting();
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Center(
            child: !isPerson
                ? Wrap(
              children: <Widget>[
                Text(columnName),
                isSorted
                    ? Icon(Icons.arrow_drop_down, size: 20.0)
                    : Icon(Icons.arrow_drop_up, size: 20.0)
              ],
            )
                : Text(columnName)),
      ),
    );
  }
}
