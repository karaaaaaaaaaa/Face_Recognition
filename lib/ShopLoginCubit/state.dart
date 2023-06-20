

abstract class socialLoginStates {}

class socialInitialState extends socialLoginStates {}

class socialLoadingState extends socialLoginStates {}

class socialloginSuccessState extends socialLoginStates {
  final String uid;

  socialloginSuccessState(this.uid);
}

class socialLoginErrorState extends socialLoginStates {
  final String error;
  socialLoginErrorState(this.error);
}

class socialLoginPasswordVisibility extends socialLoginStates {}
