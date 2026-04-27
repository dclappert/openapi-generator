@IsTest
private class PetstoreApiApiExceptionTest {
  @IsTest
  static void testConstructionAndHttpResultField() {
    final PetstoreApiApiException ex = new PetstoreApiApiException('boom');
    final PetstoreApiHttpClient.HttpResult r = new PetstoreApiHttpClient.HttpResult();
    ex.httpResult = r;
    System.assertEquals('boom', ex.getMessage());
    System.assertEquals(r, ex.httpResult);
  }
}
