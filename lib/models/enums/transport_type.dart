enum TransportType{
  car,
  motorcycle,
  bus,
  plane,
  cruise,
}

extension TransportTypeExtension on TransportType {
  String get displayString{
    switch(this){
      case TransportType.car:
        return 'Carro';
      case TransportType.motorcycle:
        return 'Moto';
      case TransportType.bus:
        return 'Onibus';
      case TransportType.plane:
        return 'Avião';
      case TransportType.cruise:
        return 'Cruseiro';
    }
  }
}