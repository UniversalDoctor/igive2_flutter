import 'dart:async';
import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';

class FitKitScreen extends StatefulWidget {

  static const String routeName = '/fitkit';

  @override
  _FitKitScreenState createState() => new _FitKitScreenState();
}

class _FitKitScreenState extends State<FitKitScreen> {

  String result = '';
  int _steps = 0;
  Map<DataType, List<FitData>> results = Map();
  bool permissions;

  RangeValues _dateRange = RangeValues(1, 8);
  List<DateTime> _dates = List<DateTime>();
  double _limitRange = 0;

  DateTime get _dateFrom => _dates[_dateRange.start.round()];
  DateTime get _dateTo => _dates[_dateRange.end.round()];
  int get _limit => _limitRange == 0.0 ? null : _limitRange.round();

  @override
  void initState(){
    super.initState();

    final now = DateTime.now();
    _dates.add(null);
    for(int i = 7; i>=0; i--){
      _dates.add(DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i)));
    }
    _dates.add(null);
    hasPermissions();
  }

  Future<void> read() async{
    results.clear();
    _steps = 0;

    try{
      permissions = await FitKit.requestPermissions(DataType.values);
      if(!permissions){
        result = 'requestPermissions: failed';
      }else{
        for(DataType type in DataType.values){
          results[type] = await FitKit.read(
            type,
            dateFrom: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
            dateTo: null,
            limit: null,
          );
        }
        result = 'readAll: success';
        for(var i = 0; i <= results[DataType.STEP_COUNT].length; i++){
          _steps = _steps + int.parse(results[DataType.STEP_COUNT][i].value.toString());
        }
      }
    }catch(e){
      result = 'readAll: $e';
    }
    setState(() { });
  }

  Future<void> revokePermissions() async{
    results.clear();

    try{
      await FitKit.revokePermissions();
      permissions = await FitKit.hasPermissions(DataType.values);
      result = 'revokePermissions: success';
    }catch(e){
      result = 'revokePermissions: $e';
    }
    setState((){ });
  }

  Future<void> hasPermissions() async{
    try{
      permissions = await FitKit.hasPermissions(DataType.values);
    }catch(e){
      result = 'hasPermissions: $e';
    }

    if(!mounted) return;

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    final items = results.entries.expand((entry) => [entry.key, ...entry.value]).toList();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Text(
                        'Date Range: ${_dateToString(_dateFrom)} - ${_dateToString(_dateTo)}'),
                    Text('Limit: $_limit'),
                    Text('Permissions: $permissions'),
                    Text('Result: $result'),
                    SizedBox(height: 40.0),
                    _buildDateSlider(context),
                    _buildLimitSlider(context),
                    _buildButtons(context),
                    // Text(results[DataType.STEP_COUNT][0].value.toString()),
                    Text('Total Steps: ' + _steps.toString()),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          if (item is DataType) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '$item - ${results[item].length}',
                                style: Theme.of(context).textTheme.title,
                              ),
                            );
                          } else if (item is FitData) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              child: Text(
                                '${item.dateFrom} - ${item.value}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  String _dateToString(DateTime dateTime){
    if(dateTime == null){
      return 'null';
    }
    return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
  }

  Widget _buildDateSlider(BuildContext context) {
    return Row(
      children: [
        Text('Date Range'),
        Expanded(
          child: RangeSlider(
            values: _dateRange,
            min: 0,
            max: 9,
            divisions: 10,
            onChanged: (values) => setState(() => _dateRange = values),
          ),
        )
      ]
    );
  }

  Widget _buildLimitSlider(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('Limit'),
        Expanded(
          child: Slider(
            value: _limitRange,
            min: 0,
            max: 4,
            divisions: 4,
            onChanged: (newValue) => setState(() => _limitRange = newValue),
          ),
        )
      ],
    );
  }

  Widget _buildButtons(BuildContext context){
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            color: Colors.black26,
            textColor: Colors.white,
            onPressed: () => read(),
            child: Text('Read'),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4,)),
        Expanded(
          child: FlatButton(
            color: Colors.black26,
            textColor: Colors.white,
            onPressed: () => revokePermissions(),
            child: Text('Revoke permissions'),
          ),
        )
      ],
    );
  }
}