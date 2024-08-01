// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:test_app_2/vesti/models/passport.dart';
// import 'package:test_app_2/vesti/services/passport_service.dart';

// class PassportNotifier extends StateNotifier<AsyncValue<Passport?>> {
//   final PassportService _passportService;

//   PassportNotifier(this._passportService) : super(const AsyncValue.loading());

//   Future<void> createPassport(Passport passport) async {
//     try {
//       state = const AsyncValue.loading();
//       final createdPassport = await _passportService.createPassport(passport);
//       state = AsyncValue.data(createdPassport);
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }

//   Future<void> uploadPassportImage({
//     required String passportImagePath,
//   }) async {
//     try {
//       state = const AsyncValue.loading();
//       final uploadedPassport = await _passportService.uploadPassportImage(
//         passportImagePath: passportImagePath,
//       );
//       state = AsyncValue.data(uploadedPassport);
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }
// }

// // Provider for PassportService


// StateNotifierProvider to expose PassportNotifier to the rest of the app
// final passportNotifierProvider =
//     StateNotifierProvider<PassportNotifier, AsyncValue<Passport?>>((ref) {
//   final passportService = ref.watch(passportServiceProvider);
//   return PassportNotifier(passportService);
// });
