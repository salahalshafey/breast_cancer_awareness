String wellFormatedDistance(double distanceInMeter) {
  if (distanceInMeter >= 1000) {
    return '${(distanceInMeter / 1000).toStringAsFixed(1)} km';
  }

  return '${distanceInMeter.toStringAsFixed(0)} meter';
}

String fromMeterPerSecToKPerH(double speed) {
  return (speed * 3.6).toStringAsFixed(0);
}

String fromKilometerPerHourToMPerSec(double speed) {
  return (speed * (5 / 18)).toStringAsFixed(0);
}
