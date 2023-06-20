

abstract class socialRegisterStates{
}
class socialRegisterInitialState extends socialRegisterStates{}
class socialRegisterLoadingState extends socialRegisterStates{}
class socialRegisterSuccessState extends socialRegisterStates{

}
class socialRegisterErrorState extends socialRegisterStates{
  final String error;
  socialRegisterErrorState(this.error);
}
class socialcreateuserSuccessState extends socialRegisterStates{

}
class socialcreateuserErrorState extends socialRegisterStates{
  final String error;
  socialcreateuserErrorState(this.error);
}
class socialRegisterPasswordVisibility extends socialRegisterStates{}