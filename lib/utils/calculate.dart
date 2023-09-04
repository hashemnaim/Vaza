double getAddedPercentageValue({
  required num percentage,
  required num totalValue,
}) {
  return double.parse((totalValue * (percentage / 100)).toStringAsFixed(2));
}
