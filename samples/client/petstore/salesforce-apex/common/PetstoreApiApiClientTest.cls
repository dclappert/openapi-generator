@IsTest
private class PetstoreApiApiClientTest {
  @IsTest
  static void testDefaultConstructor() {
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1');
    Assert.areNotEqual(null, client);
  }

  @IsTest
  static void testInjectedHttpClient() {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    Assert.areNotEqual(null, client);
  }

  @IsTest
  static void testAddHeaderReturnsSelf() {
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1');
    final PetstoreApiApiClient returned = client.addHeader('X-Test', 'value');
    Assert.areEqual(client, returned);
  }

  @IsTest
  static void testSendDelegatesToHttpClient() {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    final HttpResponse res = new HttpResponse();
    res.setStatusCode(200);
    res.setBody('{}');
    mock.nextResponse = res;
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    final PetstoreApiHttpRequestBuilder builder = new PetstoreApiHttpRequestBuilder()
      .setEndpoint('x')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpResult result = client.send(builder);
    Assert.areEqual(200, result.response.getStatusCode());
  }
}
