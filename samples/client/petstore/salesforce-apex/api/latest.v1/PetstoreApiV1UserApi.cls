@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
global virtual class PetstoreApiV1UserApi {
  private PetstoreApiApiClient client;

  global PetstoreApiV1UserApi(final PetstoreApiApiClient client) {
    this.client = client;
  }

  private PetstoreApiApiException buildApiException(final String operationId, final PetstoreApiHttpClient.HttpResult httpResult) {
    final PetstoreApiApiException ex = new PetstoreApiApiException(
      operationId + ' failed: ' + httpResult.response.getStatusCode() + ' - ' + httpResult.response.getBody()
    );
    ex.httpResult = httpResult;
    return ex;
  }


  global class CreateUserRequest {
    global PetstoreApiV1User petstoreApiV1User;

    global CreateUserRequest setPetstoreApiV1User(final PetstoreApiV1User petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }

  }

  global class CreateUserResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Create user
   * @param petstoreApiV1User Created user object (required)
   * @return void
   */
  global virtual void createUser(
    final CreateUserRequest request
  ) {
    createUserWithHttpInfo(request);
  }

  /**
   * Create user
   * @param petstoreApiV1User Created user object (required)
   * @return CreateUserResponse
   */
  global virtual CreateUserResponse createUserWithHttpInfo(
    final CreateUserRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('createUser', httpResult);
    }
    final CreateUserResponse response = new CreateUserResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class CreateUsersWithArrayInputRequest {
    global List<PetstoreApiV1User> petstoreApiV1User;

    global CreateUsersWithArrayInputRequest setPetstoreApiV1User(final List<PetstoreApiV1User> petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }

  }

  global class CreateUsersWithArrayInputResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return void
   */
  global virtual void createUsersWithArrayInput(
    final CreateUsersWithArrayInputRequest request
  ) {
    createUsersWithArrayInputWithHttpInfo(request);
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return CreateUsersWithArrayInputResponse
   */
  global virtual CreateUsersWithArrayInputResponse createUsersWithArrayInputWithHttpInfo(
    final CreateUsersWithArrayInputRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/createWithArray')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('createUsersWithArrayInput', httpResult);
    }
    final CreateUsersWithArrayInputResponse response = new CreateUsersWithArrayInputResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class CreateUsersWithListInputRequest {
    global List<PetstoreApiV1User> petstoreApiV1User;

    global CreateUsersWithListInputRequest setPetstoreApiV1User(final List<PetstoreApiV1User> petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }

  }

  global class CreateUsersWithListInputResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return void
   */
  global virtual void createUsersWithListInput(
    final CreateUsersWithListInputRequest request
  ) {
    createUsersWithListInputWithHttpInfo(request);
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return CreateUsersWithListInputResponse
   */
  global virtual CreateUsersWithListInputResponse createUsersWithListInputWithHttpInfo(
    final CreateUsersWithListInputRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/createWithList')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('createUsersWithListInput', httpResult);
    }
    final CreateUsersWithListInputResponse response = new CreateUsersWithListInputResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class DeleteUserRequest {
    global String username;

    global DeleteUserRequest setUsername(final String username) {
      this.username = username;
      return this;
    }

  }

  global class DeleteUserResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Delete user
   * @param username The name that needs to be deleted (required)
   * @return void
   */
  global virtual void deleteUser(
    final DeleteUserRequest request
  ) {
    deleteUserWithHttpInfo(request);
  }

  /**
   * Delete user
   * @param username The name that needs to be deleted (required)
   * @return DeleteUserResponse
   */
  global virtual DeleteUserResponse deleteUserWithHttpInfo(
    final DeleteUserRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/' + request.username)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.DEL);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('deleteUser', httpResult);
    }
    final DeleteUserResponse response = new DeleteUserResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class GetUserByNameRequest {
    global String username;

    global GetUserByNameRequest setUsername(final String username) {
      this.username = username;
      return this;
    }

  }

  global class GetUserByNameResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1User data;
  }

  /**
   * Get user by user name
   * @param username The name that needs to be fetched. Use user1 for testing. (required)
   * @return PetstoreApiV1User
   */
  global virtual PetstoreApiV1User getUserByName(
    final GetUserByNameRequest request
  ) {
    return getUserByNameWithHttpInfo(request).data;
  }

  /**
   * Get user by user name
   * @param username The name that needs to be fetched. Use user1 for testing. (required)
   * @return GetUserByNameResponse
   */
  global virtual GetUserByNameResponse getUserByNameWithHttpInfo(
    final GetUserByNameRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/' + request.username)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getUserByName', httpResult);
    }
    final GetUserByNameResponse response = new GetUserByNameResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1User) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1User.class);
    return response;
  }


  global class LoginUserRequest {
    global String username;

    global LoginUserRequest setUsername(final String username) {
      this.username = username;
      return this;
    }

    global String password;

    global LoginUserRequest setPassword(final String password) {
      this.password = password;
      return this;
    }

  }

  global class LoginUserResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global String data;
  }

  /**
   * Logs user into the system
   * @param username The user name for login (required)
   * @param password The password for login in clear text (required)
   * @return String
   */
  global virtual String loginUser(
    final LoginUserRequest request
  ) {
    return loginUserWithHttpInfo(request).data;
  }

  /**
   * Logs user into the system
   * @param username The user name for login (required)
   * @param password The password for login in clear text (required)
   * @return LoginUserResponse
   */
  global virtual LoginUserResponse loginUserWithHttpInfo(
    final LoginUserRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/login')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    if (request.username != null && !String.isBlank(request.username)) {
      builder.addQueryParameter('username', String.valueOf(request.username));
    }
    if (request.password != null && !String.isBlank(request.password)) {
      builder.addQueryParameter('password', String.valueOf(request.password));
    }
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('loginUser', httpResult);
    }
    final LoginUserResponse response = new LoginUserResponse();
    response.httpResult = httpResult;
    response.data = (String) JSON.deserialize(httpResult.response.getBody(), String.class);
    return response;
  }


  global class LogoutUserRequest {
  }

  global class LogoutUserResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Logs out current logged in user session
   * @return void
   */
  global virtual void logoutUser(
    final LogoutUserRequest request
  ) {
    logoutUserWithHttpInfo(request);
  }

  /**
   * Logs out current logged in user session
   * @return LogoutUserResponse
   */
  global virtual LogoutUserResponse logoutUserWithHttpInfo(
    final LogoutUserRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/logout')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('logoutUser', httpResult);
    }
    final LogoutUserResponse response = new LogoutUserResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class UpdateUserRequest {
    global String username;

    global UpdateUserRequest setUsername(final String username) {
      this.username = username;
      return this;
    }

    global PetstoreApiV1User petstoreApiV1User;

    global UpdateUserRequest setPetstoreApiV1User(final PetstoreApiV1User petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }

  }

  global class UpdateUserResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Updated user
   * @param username name that need to be deleted (required)
   * @param petstoreApiV1User Updated user object (required)
   * @return void
   */
  global virtual void updateUser(
    final UpdateUserRequest request
  ) {
    updateUserWithHttpInfo(request);
  }

  /**
   * Updated user
   * @param username name that need to be deleted (required)
   * @param petstoreApiV1User Updated user object (required)
   * @return UpdateUserResponse
   */
  global virtual UpdateUserResponse updateUserWithHttpInfo(
    final UpdateUserRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('user/' + request.username)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.PUT);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('updateUser', httpResult);
    }
    final UpdateUserResponse response = new UpdateUserResponse();
    response.httpResult = httpResult;
    return response;
  }

}
