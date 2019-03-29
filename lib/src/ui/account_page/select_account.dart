import 'package:flutter/material.dart';
import 'package:shared_expenses/src/bloc/account_bloc.dart';
import 'package:shared_expenses/src/bloc/bloc_provider.dart';

class SelectAccountWidget extends StatelessWidget {
  AccountBloc _accountBloc;

  @override
  Widget build(BuildContext context) {
    _accountBloc = BlocProvider.of<AccountBloc>(context);

    if( _accountBloc.accountNames == null) return Text('no user data');
    List<ListButtonTile> selectAccountTile = _accountBloc.currentUser.accounts.map((accountId) => ListButtonTile(title: Text(_accountBloc.accountNames[accountId]),)).toList();
    for (int i = 0; i < selectAccountTile.length; i++) {
      selectAccountTile[i].index = i;
    }

    return Column(
      children: <Widget>[
            selectAccountTile.isEmpty ? Text('No Accounts') : Text('Select Account:')
          ] +
          selectAccountTile,
    );
  }
}

class ListButtonTile extends StatelessWidget {
  final Widget title;
  int index;
  ListButtonTile({this.title, this.index});
  AccountBloc _accountBloc;

  @override
  Widget build(BuildContext context) {
    _accountBloc = BlocProvider.of<AccountBloc>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: ListTile(
        title: title,
        onTap: () => _accountBloc.accountEvent
            .add(AccountEventGoHome(accountIndex: index)),
      ),
    );
  }
}