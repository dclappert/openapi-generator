@IsTest
private class PetstoreApiV1PetApiTest {
  private static PetstoreApiV1PetApi buildApi(final HttpResponse res) {
    final PetstoreApiHttpClientMock mock = new PetstoreApiHttpClientMock();
    mock.nextResponse = res;
    final PetstoreApiApiClient client = new PetstoreApiApiClient('https://test', 'v1', mock);
    return new PetstoreApiV1PetApi(client);
  }

  private static HttpResponse makeResponse(final Integer status, final String body) {
    final HttpResponse res = new HttpResponse();
    res.setStatusCode(status);
    res.setBody(body);
    return res;
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .();
    final PetstoreApiV1PetApi. response = api.addPetWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .()
      .();
    final PetstoreApiV1PetApi. response = api.deletePetWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new List<PetstoreApiV1Pet>());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .();
    final PetstoreApiV1PetApi. response = api.findPetsByStatusWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new List<PetstoreApiV1Pet>());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .();
    final PetstoreApiV1PetApi. response = api.findPetsByTagsWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .();
    final PetstoreApiV1PetApi. response = api.getPetByIdWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .();
    final PetstoreApiV1PetApi. response = api.updatePetWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testSuccess() {
    final String body = '';
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .()
      .()
      .();
    final PetstoreApiV1PetApi. response = api.updatePetWithFormWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1ApiResponse());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.()
      .()
      .()
      .();
    final PetstoreApiV1PetApi. response = api.uploadFileWithHttpInfo(request);
    Assert.areEqual(200, response.httpResult.response.getStatusCode());
    Assert.areNotEqual(null, response.data);
  }


  @IsTest
  static void testThrowsApiExceptionOnNon2xx() {
    final PetstoreApiV1PetApi api = buildApi(makeResponse(500, '{"error":"boom"}'));

    final PetstoreApiV1PetApi. request = new PetstoreApiV1PetApi.();
    try {
      api.addPetWithHttpInfo(request);
      Assert.fail('expected PetstoreApiApiException');
    } catch (PetstoreApiApiException e) {
      Assert.areEqual(500, e.httpResult.response.getStatusCode());
    }

  }
}
