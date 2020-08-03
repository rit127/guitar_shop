
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/event/AccountEvent.dart';
import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/repository/AccountRepository.dart';
import 'package:guitarfashion/state/AccountState.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  @override
  // TODO: implement initialState
  AccountState get initialState => AccountState();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {

    AccountState accountState = new AccountState(
      isLoading: state.isLoading,
      customer: state.customer,
    );

    if(event is LoadCustomer) {
      accountState.isLoading = true;
      fetchCustomer(event.customerId);
    }

    if (event is UpdateData) {
      accountState.customer = event.customer;
      accountState.isLoading = false;
//      productState.page = productState.page+1;
      yield accountState;
    }

    if(event is FinishLoadData){
      accountState.customer = null;
      accountState.isLoading = false;
      yield accountState;
    }
  }

  fetchCustomer (String customerId) async {
    Customer myCustomer = await AccountRepository.fetchCustomer(customerId);

    if(myCustomer != null){
      add(UpdateData(myCustomer));
    }else{
      add(FinishLoadData());
    }
  }
}