@IsTest
private class PetstoreApiV1ApiResponseTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1ApiResponse m = new PetstoreApiV1ApiResponse()
      .setCode(1)
      .setType('x')
      .setMessage('x');
    System.assertNotEquals(null, m.getCode());
    System.assertNotEquals(null, m.getType());
    System.assertNotEquals(null, m.getMessage());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1ApiResponse original = new PetstoreApiV1ApiResponse()
      .setCode(1)
      .setType('x')
      .setMessage('x');
    final String json = JSON.serialize(original);
    PetstoreApiV1ApiResponse restored = (PetstoreApiV1ApiResponse) JSON.deserialize(json, PetstoreApiV1ApiResponse.class);
    System.assertNotEquals(null, restored);
  }
}
