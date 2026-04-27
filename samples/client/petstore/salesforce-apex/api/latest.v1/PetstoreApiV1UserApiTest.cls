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
  static void testCreateUserSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.CreateUserRequest request = new PetstoreApiV1UserApi.CreateUserRequest()
      .setPetstoreApiV1User(new PetstoreApiV1User());
    final PetstoreApiV1UserApi.CreateUserResponse response = api.createUserWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testCreateUsersWithArrayInputSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.CreateUsersWithArrayInputRequest request = new PetstoreApiV1UserApi.CreateUsersWithArrayInputRequest()
      .setPetstoreApiV1User(new List<PetstoreApiV1User>());
    final PetstoreApiV1UserApi.CreateUsersWithArrayInputResponse response = api.createUsersWithArrayInputWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testCreateUsersWithListInputSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.CreateUsersWithListInputRequest request = new PetstoreApiV1UserApi.CreateUsersWithListInputRequest()
      .setPetstoreApiV1User(new List<PetstoreApiV1User>());
    final PetstoreApiV1UserApi.CreateUsersWithListInputResponse response = api.createUsersWithListInputWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testDeleteUserSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.DeleteUserRequest request = new PetstoreApiV1UserApi.DeleteUserRequest()
      .setUsername('x');
    final PetstoreApiV1UserApi.DeleteUserResponse response = api.deleteUserWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testGetUserByNameSuccess() {
    final String body = JSON.serialize(new PetstoreApiV1User());
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.GetUserByNameRequest request = new PetstoreApiV1UserApi.GetUserByNameRequest()
      .setUsername('x');
    final PetstoreApiV1UserApi.GetUserByNameResponse response = api.getUserByNameWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testLoginUserSuccess() {
    final String body = JSON.serialize(new String());
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.LoginUserRequest request = new PetstoreApiV1UserApi.LoginUserRequest()
      .setUsername('x')
      .setPassword('x');
    final PetstoreApiV1UserApi.LoginUserResponse response = api.loginUserWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
    System.assertNotEquals(null, response.data);
  }


  @IsTest
  static void testLogoutUserSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.LogoutUserRequest request = new PetstoreApiV1UserApi.LogoutUserRequest();
    final PetstoreApiV1UserApi.LogoutUserResponse response = api.logoutUserWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testUpdateUserSuccess() {
    final String body = '';
    final PetstoreApiV1UserApi api = buildApi(makeResponse(200, body));
    final PetstoreApiV1UserApi.UpdateUserRequest request = new PetstoreApiV1UserApi.UpdateUserRequest()
      .setUsername('x')
      .setPetstoreApiV1User(new PetstoreApiV1User());
    final PetstoreApiV1UserApi.UpdateUserResponse response = api.updateUserWithHttpInfo(request);
    System.assertEquals(200, response.httpResult.response.getStatusCode());
  }


  @IsTest
  static void testThrowsApiExceptionOnNon2xx() {
    final PetstoreApiV1UserApi api = buildApi(makeResponse(500, '{"error":"boom"}'));

    final PetstoreApiV1UserApi.CreateUserRequest request = new PetstoreApiV1UserApi.CreateUserRequest();
    try {
      api.createUserWithHttpInfo(request);
      System.assert(false, 'expected PetstoreApiApiException');
    } catch (PetstoreApiApiException e) {
      System.assertEquals(500, e.httpResult.response.getStatusCode());
    }

  }
}
