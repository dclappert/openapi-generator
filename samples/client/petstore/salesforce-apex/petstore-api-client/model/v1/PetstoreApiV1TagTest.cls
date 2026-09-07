@IsTest
private class PetstoreApiV1TagTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1Tag m = new PetstoreApiV1Tag()
      .setId()
      .setName();
    Assert.areNotEqual(null, m.getId());
    Assert.areNotEqual(null, m.getName());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1Tag original = new PetstoreApiV1Tag()
      .setId()
      .setName();
    final String json = JSON.serialize(original);
    PetstoreApiV1Tag restored = (PetstoreApiV1Tag) JSON.deserialize(json, PetstoreApiV1Tag.class);
    Assert.areNotEqual(null, restored);
  }
}
