import 'package:guitarfashion/model/Customer.dart';

class AccountState {
  Customer customer;
  bool isLoading;

  AccountState({
    this.customer,
    this.isLoading = true,
  });
}
