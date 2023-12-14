extension NumExtension on num {
  String priceWithUnit() {
    return "$this\$";
  }

  String displaySalePercent() {
    return "-$this%";
  }
}

extension DoubleExtension on double {
  String priceWithUnit() {
    return "$this\$";
  }

  String displaySalePercent() {
    return "-$this%";
  }
}

extension IntExtension on int {
  String priceWithUnit() {
    return "$this\$";
  }

  String displaySalePercent() {
    return "-$this%";
  }
}
