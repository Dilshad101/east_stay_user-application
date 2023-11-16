import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<OpenPaymentEvent>(_paymentEvent);
    on<PaymentSuccessEvent>(_onPaymentSuccess);
    on<PaymentFailedEvent>(_onPaymentFailed);
  }
  final _razorpay = Razorpay();
  _paymentEvent(OpenPaymentEvent event, Emitter<PaymentState> emit) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    final total = event.total;
    final String propertyName = event.propertyName;
    final String mobileNumber = event.mobileNumber;

    var options = {
      'key': 'rzp_test_aPzemyrqsHf1Vf',
      'amount': total * 100,
      'name': 'East Stay',
      'description': propertyName,
      'prefill': {'contact': mobileNumber, 'email': 'test@razorpay.com'}
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('payment success');
    add(PaymentSuccessEvent());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('payment failed');
    add(PaymentFailedEvent());
  }

  _onPaymentSuccess(PaymentSuccessEvent event, Emitter<PaymentState> emit) {
    emit(PaymentSuccessState());
  }

  _onPaymentFailed(PaymentFailedEvent event, Emitter<PaymentState> emit) {
    emit(PaymentFailedState());
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}
