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
  static void testDeleteOrderSuccess() {
    final String body = '';
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi.DeleteOrderRequest request = new PetstoreApiV1StoreApi.DeleteOrderRequest()
      .setOrderId('x');
    final PetstoreApiV1StoreApi.DeleteOrderResponse response = api.deleteOrderWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testGetInventorySuccess() {
    final String body = JSON.serialize(new Map<String, Integer>());
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi.GetInventoryRequest request = new PetstoreApiV1StoreApi.GetInventoryRequest();
    final PetstoreApiV1StoreApi.GetInventoryResponse response = api.getInventoryWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testGetOrderByIdSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Order());
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi.GetOrderByIdRequest request = new PetstoreApiV1StoreApi.GetOrderByIdRequest()
      .setOrderId(1L);
    final PetstoreApiV1StoreApi.GetOrderByIdResponse response = api.getOrderByIdWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testPlaceOrderSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Order());
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1StoreApi.PlaceOrderRequest request = new PetstoreApiV1StoreApi.PlaceOrderRequest()
      .setPetstoreApiV1Order(new PetstoreApiV1Order());
    final PetstoreApiV1StoreApi.PlaceOrderResponse response = api.placeOrderWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testThrowsApiExceptionOnNon2xx() {
    final PetstoreApiV1StoreApi api = buildApi(makeResponse(500, '{"error":"boom"}'));

    final PetstoreApiV1StoreApi.DeleteOrderRequest request = new PetstoreApiV1StoreApi.DeleteOrderRequest();
    try {
      api.deleteOrderWithHttpInfo(request);
      System.assert(false, 'expected PetstoreApiApiException');
    } catch (PetstoreApiApiException e) {
      System.assertEquals(500, e.httpResult.response.getStatusCode());
    }

  }
}
