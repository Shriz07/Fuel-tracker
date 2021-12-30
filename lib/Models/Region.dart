class Region {
  Region({
    required this.name,
    required this.price95,
    required this.price98,
    required this.priceON,
    required this.priceONplus,
    required this.priceLPG,
  });

  String name;
  //Data could be n.d so String
  String price95;
  String price98;
  String priceON;
  String priceONplus;
  String priceLPG;
}
