@IsTest
private class PetstoreApiV1TagTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1Tag m = new PetstoreApiV1Tag()
      .setId(1L)
      .setName('x');
    System.assertNotEquals(null, m.getId());
    System.assertNotEquals(null, m.getName());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1Tag original = new PetstoreApiV1Tag()
      .setId(1L)
      .setName('x');
    final String json = JSON.serialize(original);
    PetstoreApiV1Tag restored = (PetstoreApiV1Tag) JSON.deserialize(json, PetstoreApiV1Tag.class);
    System.assertNotEquals(null, restored);
  }
}
