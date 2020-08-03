
import 'package:guitarfashion/model/Customer.dart';

abstract class AccountEvent {
  List prop = const [];
}

class LoadCustomer extends AccountEvent {
  String customerId;

  LoadCustomer(this.customerId);

  @override
  // TODO: implement props
  List<Object> get props => [this.customerId];
}

class UpdateData extends AccountEvent{

  Customer customer;

  UpdateData(this.customer);

  @override
  // TODO: implement props
  List<Object> get props => [customer];
}

class FinishLoadData extends AccountEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
}