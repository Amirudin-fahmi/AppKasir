import 'package:parfumhana_kasir/app/data/source/payment_method_api_service.dart';
import 'package:parfumhana_kasir/app/domain/entity/payment_method.dart';
import 'package:parfumhana_kasir/app/domain/repository/payment_method_repository.dart';
import 'package:parfumhana_kasir/core/network/data_state.dart';

class PaymentMethodRepositoryImpl extends PaymentMethodRepository {
  final PaymentMethodApiService _paymentMethodApiService;

  PaymentMethodRepositoryImpl(this._paymentMethodApiService);

  @override
  Future<DataState<List<PaymentMethodEntity>>> getAll() {
    return handleResponse(
        () => _paymentMethodApiService.getAll(),
        (json) => List<PaymentMethodEntity>.from(
            json.map((item) => PaymentMethodEntity.fromJson(item))));
  }
}
