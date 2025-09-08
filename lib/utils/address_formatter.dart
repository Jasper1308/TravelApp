String formatStopAddress(Map<String, dynamic> address){
  final addressParts = [];

  if (address.containsKey('municipality') && address['municipality'].isNotEmpty) {
    addressParts.add(address['municipality']);
  }
  if (address.containsKey('state') && address['state'].isNotEmpty) {
    addressParts.add(address['state']);
  }
  if (address.containsKey('country') && address['country'].isNotEmpty) {
    addressParts.add(address['country']);
  }

  return addressParts.join(', ');
}