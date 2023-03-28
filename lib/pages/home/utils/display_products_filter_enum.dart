enum DisplayProductsFilterEnum { price, discountPercentage, name }

extension DisplayProductsFilterEnumCaption on DisplayProductsFilterEnum {
  String getCaption() {
    switch (this) {
      case DisplayProductsFilterEnum.price:
        return "Price";
      case DisplayProductsFilterEnum.discountPercentage:
        return "Discount %";
      case DisplayProductsFilterEnum.name:
        return "Name";
    }
  }
}
