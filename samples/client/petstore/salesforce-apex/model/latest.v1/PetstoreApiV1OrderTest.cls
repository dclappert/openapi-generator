@IsTest
private class PetstoreApiV1OrderTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1Order m = new PetstoreApiV1Order()
      .setId(1L)
      .setPetId(1L)
      .setQuantity(1)
      .setShipDate(Datetime.now())
      .setStatus('x')
      .setComplete(true);
    Assert.areNotEqual(null, m.getId());
    Assert.areNotEqual(null, m.getPetId());
    Assert.areNotEqual(null, m.getQuantity());
    Assert.areNotEqual(null, m.getShipDate());
    Assert.areNotEqual(null, m.getStatus());
    Assert.areNotEqual(null, m.getComplete());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1Order original = new PetstoreApiV1Order()
      .setId(1L)
      .setPetId(1L)
      .setQuantity(1)
      .setShipDate(Datetime.now())
      .setStatus('x')
      .setComplete(true);
    final String json = JSON.serialize(original);
    PetstoreApiV1Order restored = (PetstoreApiV1Order) JSON.deserialize(json, PetstoreApiV1Order.class);
    Assert.areNotEqual(null, restored);
  }
}
