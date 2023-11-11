import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/data/models/ip_info_model.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/data/services/ip_services.dart';
import 'package:grocery_app/data/services/sign_in_service.dart';
import 'package:meta/meta.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitial());

  UserModel? currentUser;
  SignInService signInService = SignInService();
  IpInfoModel? ipInfo;
  IpServices ipServices = IpServices();

  Future<void> init() async {
    await setUser();
    await setIpInfo();
  }

  Future<void> setUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      currentUser = await signInService.getUserFromFireStore(
          uid: FirebaseAuth.instance.currentUser!.uid);
      emit(InfoInitial());
    }
  }

  Future<void> setIpInfo() async {
    try {
      ipInfo = await ipServices.setIpInfo();
    } catch (_) {}
  }

  @override
  void emit(InfoState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
