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
  static void testAddPetSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.AddPetRequest request = new PetstoreApiV1PetApi.AddPetRequest()
      .setPetstoreApiV1Pet(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi.AddPetResponse response = api.addPetWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testDeletePetSuccess() {
    final String body = '';
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.DeletePetRequest request = new PetstoreApiV1PetApi.DeletePetRequest()
      .setPetId(1L)
      .setApiKey('x');
    final PetstoreApiV1PetApi.DeletePetResponse response = api.deletePetWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testFindPetsByStatusSuccess() {
    final String body = JSON.serialize(new List<PetstoreApiV1Pet>());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.FindPetsByStatusRequest request = new PetstoreApiV1PetApi.FindPetsByStatusRequest()
      .setStatus(new List<String>());
    final PetstoreApiV1PetApi.FindPetsByStatusResponse response = api.findPetsByStatusWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testFindPetsByTagsSuccess() {
    final String body = JSON.serialize(new List<PetstoreApiV1Pet>());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.FindPetsByTagsRequest request = new PetstoreApiV1PetApi.FindPetsByTagsRequest()
      .setTags(new List<String>());
    final PetstoreApiV1PetApi.FindPetsByTagsResponse response = api.findPetsByTagsWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testGetPetByIdSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.GetPetByIdRequest request = new PetstoreApiV1PetApi.GetPetByIdRequest()
      .setPetId(1L);
    final PetstoreApiV1PetApi.GetPetByIdResponse response = api.getPetByIdWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testUpdatePetSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.UpdatePetRequest request = new PetstoreApiV1PetApi.UpdatePetRequest()
      .setPetstoreApiV1Pet(new PetstoreApiV1Pet());
    final PetstoreApiV1PetApi.UpdatePetResponse response = api.updatePetWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testUpdatePetWithFormSuccess() {
    final String body = '';
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.UpdatePetWithFormRequest request = new PetstoreApiV1PetApi.UpdatePetWithFormRequest()
      .setPetId(1L)
      .setName('x')
      .setStatus('x');
    final PetstoreApiV1PetApi.UpdatePetWithFormResponse response = api.updatePetWithFormWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testUploadFileSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1ApiResponse());
    final PetstoreApiV1PetApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1PetApi.UploadFileRequest request = new PetstoreApiV1PetApi.UploadFileRequest()
      .setPetId(1L)
      .setAdditionalMetadata('x')
      .setFile(Blob.valueOf('x'));
    final PetstoreApiV1PetApi.UploadFileResponse response = api.uploadFileWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testThrowsApiExceptionOnNon2xx() {
    final PetstoreApiV1PetApi api = buildApi(makeResponse(500, '{"error":"boom"}'));

    final PetstoreApiV1PetApi.AddPetRequest request = new PetstoreApiV1PetApi.AddPetRequest();
    try {
      api.addPetWithHttpInfo(request);
      System.assert(false, 'expected PetstoreApiApiException');
    } catch (PetstoreApiApiException e) {
      System.assertEquals(500, e.httpResult.response.getStatusCode());
    }

  }
}
