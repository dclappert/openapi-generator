@IsTest
private class PetstoreApiHttpClientTest {
  private class FixedMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
      final HttpResponse r = new HttpResponse();
      r.setStatusCode(200);
      r.setBody('{}');
      return r;
    }
  }

  @IsTest
  static void testSendReturnsHttpResult() {
    Test.setMock(HttpCalloutMock.class, new FixedMock());
    final HttpRequest req = new HttpRequest();
    req.setEndpoint('https://test');
    req.setMethod('GET');
    Test.startTest();
    final PetstoreApiHttpClient.HttpResult result = new PetstoreApiHttpClient().send(req);
    Test.stopTest();
    Assert.areEqual(200, result.response.getStatusCode());
    Assert.areEqual(req, result.request);
  }
}
