import 'package:geocoding/geocoding.dart';

Future<String?> getPincodeFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      return placemarks.first.postalCode; // This is the pincode
    }
  } catch (e) {
    print("Error in reverse geocoding: $e");
  }
  return null;
}
void fetchPincode(double lat,double lng) async {
 
 String? pincode = await getPincodeFromLatLng(lat, lng);
  if (pincode != null) {
    print("Pincode: $pincode");
  } else {
    print("Failed to get pincode.");
  }
}