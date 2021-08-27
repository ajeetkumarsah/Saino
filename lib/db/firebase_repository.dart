import 'package:saino/db/firebase_provider.dart';

class FirebaseRepository {
   Future<bool> addNewTrucks({required Map<String, dynamic> map}) =>
      firebaseProvider.addNewTrucks(map: map);
}
//Global Key For Bloc Class
FirebaseRepository firebaseRepository = FirebaseRepository();