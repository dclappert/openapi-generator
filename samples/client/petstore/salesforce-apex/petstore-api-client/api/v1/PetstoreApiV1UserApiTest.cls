@IsTest
private class PetstoreApiV1UserApiTest {
  private static PetstoreApiV1UserApi buildApi(final HttpResponse res) {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    mock.nextResponse = res;
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    return new PetstoreApiV1UserApi(client);
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
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .();
    final PetstoreApiV1UserApi. response = api.createUserWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .();
    final PetstoreApiV1UserApi. response = api.createUsersWithArrayInputWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .();
    final PetstoreApiV1UserApi. response = api.createUsersWithListInputWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .();
    final PetstoreApiV1UserApi. response = api.deleteUserWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1User());
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .();
    final PetstoreApiV1UserApi. response = api.getUserByNameWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new String());
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .()
      .();
    final PetstoreApiV1UserApi. response = api.loginUserWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.();
    final PetstoreApiV1UserApi. response = api.logoutUserWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.()
      .()
      .();
    final PetstoreApiV1UserApi. response = api.updateUserWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testThrowsApiExceptionOnNon2xx() {
    final PetstoreApiV1UserApi api = buildApi(makeResponse(500, '{"error":"boom"}'));

    final PetstoreApiV1UserApi. request = new PetstoreApiV1UserApi.();
    try {
      api.createUserWithHttpInfo(request);
      Assert.fail('expected PetstoreApiApiException');
    } catch (PetstoreApiApiException e) {
      Assert.areEqual(500, e.httpResult.response.getStatusCode());
    }

  }
}
