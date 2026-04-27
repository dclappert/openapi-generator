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
    System.assertNotEquals(null, m.getId());
    System.assertNotEquals(null, m.getPetId());
    System.assertNotEquals(null, m.getQuantity());
    System.assertNotEquals(null, m.getShipDate());
    System.assertNotEquals(null, m.getStatus());
    System.assertNotEquals(null, m.getComplete());
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
    System.assertNotEquals(null, restored);
  }
}
