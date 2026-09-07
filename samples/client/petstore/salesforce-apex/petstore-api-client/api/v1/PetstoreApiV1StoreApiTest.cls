@IsTest
private class PetstoreApiV1StoreApiTest {
  private static PetstoreApiV1StoreApi buildApi(final HttpResponse res) {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    mock.nextResponse = res;
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    return new PetstoreApiV1StoreApi(client);
  }

  private static HttpResponse makeResponse(final Integer status, final String body) {
    final HttpResponse res = new HttpResponse();
    res.setStatusCode(status);
    res.setBody(body);
    return res;
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi. request = new PetstoreApiV1StoreApi.()
      .();
    final PetstoreApiV1StoreApi. response = api.deleteOrderWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new Map<String, Integer>());
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi. request = new PetstoreApiV1StoreApi.();
    final PetstoreApiV1StoreApi. response = api.getInventoryWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Order());
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi. request = new PetstoreApiV1StoreApi.()
      .();
    final PetstoreApiV1StoreApi. response = api.getOrderByIdWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Order());
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi. request = new PetstoreApiV1StoreApi.()
      .();
    final PetstoreApiV1StoreApi. response = api.placeOrderWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testThrowsApiExceptionOnNon2xx() {
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(500, '{"error":"boom"}'));

    final PetstoreApiV1StoreApi. request = new PetstoreApiV1StoreApi.();
    try {
      api.deleteOrderWithHttpInfo(request);
      Assert.fail('expected PetstoreApiApiException');
    } catch (PetstoreApiApiException e) {
      Assert.areEqual(500, e.httpResult.response.getStatusCode());
    }

  }
}
