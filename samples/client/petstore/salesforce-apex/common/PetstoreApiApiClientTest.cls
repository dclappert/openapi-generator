@IsTest
private class PetstoreApiApiClientTest {
  @IsTest
  static void testDefaultConstructor() {
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1');
    System.assertNotEquals(null, client);
  }

  @IsTest
  static void testInjectedHttpClient() {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    System.assertNotEquals(null, client);
  }

  @IsTest
  static void testAddHeaderReturnsSelf() {
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1');
    final PetstoreApiApiClient returned = client.addHeader('X-Test', 'value');
    System.assertEquals(client, returned);
  }

  @IsTest
  static void testSendDelegatesToHttpClient() {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    final HttpResponse res = new HttpResponse();
    res.setStatusCode(200);
    res.setBody('{}');
    mock.nextResponse = res;
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('x')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpClient.HttpResult result = client.send(builder);
    System.assertEquals(200, result.response.getStatusCode());
  }
}
