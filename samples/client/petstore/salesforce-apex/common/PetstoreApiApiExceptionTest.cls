@IsTest
private class PetstoreApiApiExceptionTest {
  @IsTest
  static void testConstructionAndHttpResultField() {
    final PetstoreApiApiException ex = new PetstoreApiApiException('boom');
    final PetstoreApiHttpClient.HttpResult r = new PetstoreApiHttpClient.HttpResult();
    ex.httpResult = r;
    Assert.areEqual('boom', ex.getMessage());
    Assert.areEqual(r, ex.httpResult);
  }
}
