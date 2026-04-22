@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
global virtual class PetstoreApiV1StoreApi {
  private PetstoreApiApiClient client;

  global PetstoreApiV1StoreApi(final PetstoreApiApiClient client) {
    this.client = client;
  }

  private PetstoreApiApiException buildApiException(final String operationId, final PetstoreApiHttpClient.HttpResult httpResult) {
    final PetstoreApiApiException ex = new PetstoreApiApiException(
      operationId + ' failed: ' + httpResult.response.getStatusCode() + ' - ' + httpResult.response.getBody()
    );
    ex.httpResult = httpResult;
    return ex;
  }


  global class DeleteOrderRequest {
    global String orderId;

    global DeleteOrderRequest setOrderId(final String orderId) {
      this.orderId = orderId;
      return this;
    }

  }

  global class DeleteOrderResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Delete purchase order by ID
   * @param orderId ID of the order that needs to be deleted (required)
   * @return void
   */
  global virtual void deleteOrder(
    final DeleteOrderRequest request
  ) {
    deleteOrderWithHttpInfo(request);
  }

  /**
   * Delete purchase order by ID
   * @param orderId ID of the order that needs to be deleted (required)
   * @return DeleteOrderResponse
   */
  global virtual DeleteOrderResponse deleteOrderWithHttpInfo(
    final DeleteOrderRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('store/order/' + request.orderId)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.DEL);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('deleteOrder', httpResult);
    }
    final DeleteOrderResponse response = new DeleteOrderResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class GetInventoryRequest {
  }

  global class GetInventoryResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global Map<String, Integer> data;
  }

  /**
   * Returns pet inventories by status
   * @return Map<String, Integer>
   */
  global virtual Map<String, Integer> getInventory(
    final GetInventoryRequest request
  ) {
    return getInventoryWithHttpInfo(request).data;
  }

  /**
   * Returns pet inventories by status
   * @return GetInventoryResponse
   */
  global virtual GetInventoryResponse getInventoryWithHttpInfo(
    final GetInventoryRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('store/inventory')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getInventory', httpResult);
    }
    final GetInventoryResponse response = new GetInventoryResponse();
    response.httpResult = httpResult;
    response.data = (Map<String, Integer>) JSON.deserialize(httpResult.response.getBody(), Map<String, Integer>.class);
    return response;
  }


  global class GetOrderByIdRequest {
    global Long orderId;

    global GetOrderByIdRequest setOrderId(final Long orderId) {
      this.orderId = orderId;
      return this;
    }

  }

  global class GetOrderByIdResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1Order data;
  }

  /**
   * Find purchase order by ID
   * @param orderId ID of pet that needs to be fetched (required)
   * @return PetstoreApiV1Order
   */
  global virtual PetstoreApiV1Order getOrderById(
    final GetOrderByIdRequest request
  ) {
    return getOrderByIdWithHttpInfo(request).data;
  }

  /**
   * Find purchase order by ID
   * @param orderId ID of pet that needs to be fetched (required)
   * @return GetOrderByIdResponse
   */
  global virtual GetOrderByIdResponse getOrderByIdWithHttpInfo(
    final GetOrderByIdRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('store/order/' + request.orderId)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getOrderById', httpResult);
    }
    final GetOrderByIdResponse response = new GetOrderByIdResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Order) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Order.class);
    return response;
  }


  global class PlaceOrderRequest {
    global PetstoreApiV1Order petstoreApiV1Order;

    global PlaceOrderRequest setPetstoreApiV1Order(final PetstoreApiV1Order petstoreApiV1Order) {
      this.petstoreApiV1Order = petstoreApiV1Order;
      return this;
    }

  }

  global class PlaceOrderResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1Order data;
  }

  /**
   * Place an order for a pet
   * @param petstoreApiV1Order order placed for purchasing the pet (required)
   * @return PetstoreApiV1Order
   */
  global virtual PetstoreApiV1Order placeOrder(
    final PlaceOrderRequest request
  ) {
    return placeOrderWithHttpInfo(request).data;
  }

  /**
   * Place an order for a pet
   * @param petstoreApiV1Order order placed for purchasing the pet (required)
   * @return PlaceOrderResponse
   */
  global virtual PlaceOrderResponse placeOrderWithHttpInfo(
    final PlaceOrderRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('store/order')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    builder.setBody(JSON.serialize(request.petstoreApiV1Order));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('placeOrder', httpResult);
    }
    final PlaceOrderResponse response = new PlaceOrderResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Order) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Order.class);
    return response;
  }

}
