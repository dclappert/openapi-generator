@IsTest
private class PetstoreApiV1CategoryTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1Category m = new PetstoreApiV1Category()
      .setId(1L)
      .setName('x');
    System.assertNotEquals(null, m.getId());
    System.assertNotEquals(null, m.getName());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1Category original = new PetstoreApiV1Category()
      .setId(1L)
      .setName('x');
    final String json = JSON.serialize(original);
    PetstoreApiV1Category restored = (PetstoreApiV1Category) JSON.deserialize(json, PetstoreApiV1Category.class);
    System.assertNotEquals(null, restored);
  }
}
