@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
global virtual class PetstoreApiV1UserApi {
  private PetstoreApiApiClient client;

  global PetstoreApiV1UserApi(final PetstoreApiApiClient client) {
    this.client = client;
  }

  private PetstoreApiApiException buildApiException(final String operationId, final  httpResult) {
    final PetstoreApiApiException ex = new PetstoreApiApiException(
      operationId + ' failed: ' + httpResult.response.getStatusCode() + ' - ' + httpResult.response.getBody()
    );
    ex.httpResult = httpResult;
    return ex;
  }

  global class  {
    global PetstoreApiV1User petstoreApiV1User;

    global  (final PetstoreApiV1User petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Create user
   * @param petstoreApiV1User Created user object (required)
   * @return void
   */
  global virtual void createUser(
    final  request
  ) {
    createUserWithHttpInfo(request);
  }

  /**
   * Create user
   * @param petstoreApiV1User Created user object (required)
   * @return 
   */
  global virtual  createUserWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('createUser', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global List<PetstoreApiV1User> petstoreApiV1User;

    global  (final List<PetstoreApiV1User> petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return void
   */
  global virtual void createUsersWithArrayInput(
    final  request
  ) {
    createUsersWithArrayInputWithHttpInfo(request);
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return 
   */
  global virtual  createUsersWithArrayInputWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('createUsersWithArrayInput', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global List<PetstoreApiV1User> petstoreApiV1User;

    global  (final List<PetstoreApiV1User> petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return void
   */
  global virtual void createUsersWithListInput(
    final  request
  ) {
    createUsersWithListInputWithHttpInfo(request);
  }

  /**
   * Creates list of users with given input array
   * @param petstoreApiV1User List of user object (required)
   * @return 
   */
  global virtual  createUsersWithListInputWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('createUsersWithListInput', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global String username;

    global  (final String username) {
      this.username = username;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Delete user
   * @param username The name that needs to be deleted (required)
   * @return void
   */
  global virtual void deleteUser(
    final  request
  ) {
    deleteUserWithHttpInfo(request);
  }

  /**
   * Delete user
   * @param username The name that needs to be deleted (required)
   * @return 
   */
  global virtual  deleteUserWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('deleteUser', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global String username;

    global  (final String username) {
      this.username = username;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global PetstoreApiV1User data;
  }

  /**
   * Get user by user name
   * @param username The name that needs to be fetched. Use user1 for testing. (required)
   * @return PetstoreApiV1User
   */
  global virtual PetstoreApiV1User getUserByName(
    final  request
  ) {
    return getUserByNameWithHttpInfo(request).data;
  }

  /**
   * Get user by user name
   * @param username The name that needs to be fetched. Use user1 for testing. (required)
   * @return 
   */
  global virtual  getUserByNameWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getUserByName', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1User) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1User.class);
    return response;
  }

  global class  {
    global String username;
    global String password;

    global  (final String username) {
      this.username = username;
      return this;
    }

    global  (final String password) {
      this.password = password;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global String data;
  }

  /**
   * Logs user into the system
   * @param username The user name for login (required)
   * @param password The password for login in clear text (required)
   * @return String
   */
  global virtual String loginUser(
    final  request
  ) {
    return loginUserWithHttpInfo(request).data;
  }

  /**
   * Logs user into the system
   * @param username The user name for login (required)
   * @param password The password for login in clear text (required)
   * @return 
   */
  global virtual  loginUserWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    if (request.username != null && String.isNotBlank(request.username)) {
      builder.addQueryParameter('username', String.valueOf(request.username));
    }
    if (request.password != null && String.isNotBlank(request.password)) {
      builder.addQueryParameter('password', String.valueOf(request.password));
    }
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('loginUser', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (String) JSON.deserialize(httpResult.response.getBody(), String.class);
    return response;
  }

  global class  {
  }

  global class  {
    global  httpResult;
  }

  /**
   * Logs out current logged in user session
   * @return void
   */
  global virtual void logoutUser(
    final  request
  ) {
    logoutUserWithHttpInfo(request);
  }

  /**
   * Logs out current logged in user session
   * @return 
   */
  global virtual  logoutUserWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('logoutUser', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global String username;
    global PetstoreApiV1User petstoreApiV1User;

    global  (final String username) {
      this.username = username;
      return this;
    }

    global  (final PetstoreApiV1User petstoreApiV1User) {
      this.petstoreApiV1User = petstoreApiV1User;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Updated user
   * @param username name that need to be deleted (required)
   * @param petstoreApiV1User Updated user object (required)
   * @return void
   */
  global virtual void updateUser(
    final  request
  ) {
    updateUserWithHttpInfo(request);
  }

  /**
   * Updated user
   * @param username name that need to be deleted (required)
   * @param petstoreApiV1User Updated user object (required)
   * @return 
   */
  global virtual  updateUserWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1User));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('updateUser', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

}
