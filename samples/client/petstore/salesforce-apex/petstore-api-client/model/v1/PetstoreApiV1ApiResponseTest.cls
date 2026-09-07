@IsTest
private class PetstoreApiV1ApiResponseTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1ApiResponse m = new PetstoreApiV1ApiResponse()
      .setCode()
      .setType()
      .setMessage();
    Assert.areNotEqual(null, m.getCode());
    Assert.areNotEqual(null, m.getType());
    Assert.areNotEqual(null, m.getMessage());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1ApiResponse original = new PetstoreApiV1ApiResponse()
      .setCode()
      .setType()
      .setMessage();
    final String json = JSON.serialize(original);
    PetstoreApiV1ApiResponse restored = (PetstoreApiV1ApiResponse) JSON.deserialize(json, PetstoreApiV1ApiResponse.class);
    Assert.areNotEqual(null, restored);
  }
}
