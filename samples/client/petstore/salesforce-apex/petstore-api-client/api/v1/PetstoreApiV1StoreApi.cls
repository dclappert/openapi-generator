@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
global virtual class PetstoreApiV1StoreApi {
  private PetstoreApiApiClient client;

  global PetstoreApiV1StoreApi(final PetstoreApiApiClient client) {
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
    global String orderId;

    global  (final String orderId) {
      this.orderId = orderId;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Delete purchase order by ID
   * @param orderId ID of the order that needs to be deleted (required)
   * @return void
   */
  global virtual void deleteOrder(
    final  request
  ) {
    deleteOrderWithHttpInfo(request);
  }

  /**
   * Delete purchase order by ID
   * @param orderId ID of the order that needs to be deleted (required)
   * @return 
   */
  global virtual  deleteOrderWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('deleteOrder', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
  }

  global class  {
    global  httpResult;
    global Map<String, Integer> data;
  }

  /**
   * Returns pet inventories by status
   * @return Map<String, Integer>
   */
  global virtual Map<String, Integer> getInventory(
    final  request
  ) {
    return getInventoryWithHttpInfo(request).data;
  }

  /**
   * Returns pet inventories by status
   * @return 
   */
  global virtual  getInventoryWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getInventory', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (Map<String, Integer>) JSON.deserialize(httpResult.response.getBody(), Map<String, Integer>.class);
    return response;
  }

  global class  {
    global Long orderId;

    global  (final Long orderId) {
      this.orderId = orderId;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global PetstoreApiV1Order data;
  }

  /**
   * Find purchase order by ID
   * @param orderId ID of pet that needs to be fetched (required)
   * @return PetstoreApiV1Order
   */
  global virtual PetstoreApiV1Order getOrderById(
    final  request
  ) {
    return getOrderByIdWithHttpInfo(request).data;
  }

  /**
   * Find purchase order by ID
   * @param orderId ID of pet that needs to be fetched (required)
   * @return 
   */
  global virtual  getOrderByIdWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getOrderById', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Order) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Order.class);
    return response;
  }

  global class  {
    global PetstoreApiV1Order petstoreApiV1Order;

    global  (final PetstoreApiV1Order petstoreApiV1Order) {
      this.petstoreApiV1Order = petstoreApiV1Order;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global PetstoreApiV1Order data;
  }

  /**
   * Place an order for a pet
   * @param petstoreApiV1Order order placed for purchasing the pet (required)
   * @return PetstoreApiV1Order
   */
  global virtual PetstoreApiV1Order placeOrder(
    final  request
  ) {
    return placeOrderWithHttpInfo(request).data;
  }

  /**
   * Place an order for a pet
   * @param petstoreApiV1Order order placed for purchasing the pet (required)
   * @return 
   */
  global virtual  placeOrderWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1Order));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('placeOrder', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Order) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Order.class);
    return response;
  }

}
