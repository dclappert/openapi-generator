@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
global virtual class PetstoreApiV1PetApi {
  private PetstoreApiApiClient client;

  global PetstoreApiV1PetApi(final PetstoreApiApiClient client) {
    this.client = client;
  }

  private PetstoreApiApiException buildApiException(final String operationId, final PetstoreApiHttpClient.HttpResult httpResult) {
    final PetstoreApiApiException ex = new PetstoreApiApiException(
      operationId + ' failed: ' + httpResult.response.getStatusCode() + ' - ' + httpResult.response.getBody()
    );
    ex.httpResult = httpResult;
    return ex;
  }


  global class AddPetRequest {
    global PetstoreApiV1Pet petstoreApiV1Pet;

    global AddPetRequest setPetstoreApiV1Pet(final PetstoreApiV1Pet petstoreApiV1Pet) {
      this.petstoreApiV1Pet = petstoreApiV1Pet;
      return this;
    }

  }

  global class AddPetResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1Pet data;
  }

  /**
   * Add a new pet to the store
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return PetstoreApiV1Pet
   */
  global virtual PetstoreApiV1Pet addPet(
    final AddPetRequest request
  ) {
    return addPetWithHttpInfo(request).data;
  }

  /**
   * Add a new pet to the store
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return AddPetResponse
   */
  global virtual AddPetResponse addPetWithHttpInfo(
    final AddPetRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    builder.setBody(JSON.serialize(request.petstoreApiV1Pet));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('addPet', httpResult);
    }
    final AddPetResponse response = new AddPetResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Pet) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Pet.class);
    return response;
  }


  global class DeletePetRequest {
    global Long petId;

    global DeletePetRequest setPetId(final Long petId) {
      this.petId = petId;
      return this;
    }

    global String apiKey;

    global DeletePetRequest setApiKey(final String apiKey) {
      this.apiKey = apiKey;
      return this;
    }

  }

  global class DeletePetResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Deletes a pet
   * @param petId Pet id to delete (required)
   * @param apiKey  (optional)
   * @return void
   */
  global virtual void deletePet(
    final DeletePetRequest request
  ) {
    deletePetWithHttpInfo(request);
  }

  /**
   * Deletes a pet
   * @param petId Pet id to delete (required)
   * @param apiKey  (optional)
   * @return DeletePetResponse
   */
  global virtual DeletePetResponse deletePetWithHttpInfo(
    final DeletePetRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/' + request.petId)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.DEL);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('deletePet', httpResult);
    }
    final DeletePetResponse response = new DeletePetResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class FindPetsByStatusRequest {
    global List<String> status;

    global FindPetsByStatusRequest setStatus(final List<String> status) {
      this.status = status;
      return this;
    }

  }

  global class FindPetsByStatusResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global List<PetstoreApiV1Pet> data;
  }

  /**
   * Finds Pets by status
   * @param status Status values that need to be considered for filter (required)
   * @return List<PetstoreApiV1Pet>
   */
  global virtual List<PetstoreApiV1Pet> findPetsByStatus(
    final FindPetsByStatusRequest request
  ) {
    return findPetsByStatusWithHttpInfo(request).data;
  }

  /**
   * Finds Pets by status
   * @param status Status values that need to be considered for filter (required)
   * @return FindPetsByStatusResponse
   */
  global virtual FindPetsByStatusResponse findPetsByStatusWithHttpInfo(
    final FindPetsByStatusRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/findByStatus')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    if (request.status != null && !request.status.isEmpty()) {
      final List<String> statusStrs = new List<String>();
      for (String item : request.status) {
        statusStrs.add(String.valueOf(item));
      }
      builder.addQueryParameter('status', String.join(statusStrs, ','));
    }
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('findPetsByStatus', httpResult);
    }
    final FindPetsByStatusResponse response = new FindPetsByStatusResponse();
    response.httpResult = httpResult;
    response.data = (List<PetstoreApiV1Pet>) JSON.deserialize(httpResult.response.getBody(), List<PetstoreApiV1Pet>.class);
    return response;
  }


  global class FindPetsByTagsRequest {
    global List<String> tags;

    global FindPetsByTagsRequest setTags(final List<String> tags) {
      this.tags = tags;
      return this;
    }

  }

  global class FindPetsByTagsResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global List<PetstoreApiV1Pet> data;
  }

  /**
   * Finds Pets by tags
   * @param tags Tags to filter by (required)
   * @return List<PetstoreApiV1Pet>
   */
  global virtual List<PetstoreApiV1Pet> findPetsByTags(
    final FindPetsByTagsRequest request
  ) {
    return findPetsByTagsWithHttpInfo(request).data;
  }

  /**
   * Finds Pets by tags
   * @param tags Tags to filter by (required)
   * @return FindPetsByTagsResponse
   */
  global virtual FindPetsByTagsResponse findPetsByTagsWithHttpInfo(
    final FindPetsByTagsRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/findByTags')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    if (request.tags != null && !request.tags.isEmpty()) {
      final List<String> tagsStrs = new List<String>();
      for (String item : request.tags) {
        tagsStrs.add(String.valueOf(item));
      }
      builder.addQueryParameter('tags', String.join(tagsStrs, ','));
    }
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('findPetsByTags', httpResult);
    }
    final FindPetsByTagsResponse response = new FindPetsByTagsResponse();
    response.httpResult = httpResult;
    response.data = (List<PetstoreApiV1Pet>) JSON.deserialize(httpResult.response.getBody(), List<PetstoreApiV1Pet>.class);
    return response;
  }


  global class GetPetByIdRequest {
    global Long petId;

    global GetPetByIdRequest setPetId(final Long petId) {
      this.petId = petId;
      return this;
    }

  }

  global class GetPetByIdResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1Pet data;
  }

  /**
   * Find pet by ID
   * @param petId ID of pet to return (required)
   * @return PetstoreApiV1Pet
   */
  global virtual PetstoreApiV1Pet getPetById(
    final GetPetByIdRequest request
  ) {
    return getPetByIdWithHttpInfo(request).data;
  }

  /**
   * Find pet by ID
   * @param petId ID of pet to return (required)
   * @return GetPetByIdResponse
   */
  global virtual GetPetByIdResponse getPetByIdWithHttpInfo(
    final GetPetByIdRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/' + request.petId)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getPetById', httpResult);
    }
    final GetPetByIdResponse response = new GetPetByIdResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Pet) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Pet.class);
    return response;
  }


  global class UpdatePetRequest {
    global PetstoreApiV1Pet petstoreApiV1Pet;

    global UpdatePetRequest setPetstoreApiV1Pet(final PetstoreApiV1Pet petstoreApiV1Pet) {
      this.petstoreApiV1Pet = petstoreApiV1Pet;
      return this;
    }

  }

  global class UpdatePetResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1Pet data;
  }

  /**
   * Update an existing pet
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return PetstoreApiV1Pet
   */
  global virtual PetstoreApiV1Pet updatePet(
    final UpdatePetRequest request
  ) {
    return updatePetWithHttpInfo(request).data;
  }

  /**
   * Update an existing pet
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return UpdatePetResponse
   */
  global virtual UpdatePetResponse updatePetWithHttpInfo(
    final UpdatePetRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.PUT);
    builder.setBody(JSON.serialize(request.petstoreApiV1Pet));
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('updatePet', httpResult);
    }
    final UpdatePetResponse response = new UpdatePetResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Pet) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Pet.class);
    return response;
  }


  global class UpdatePetWithFormRequest {
    global Long petId;

    global UpdatePetWithFormRequest setPetId(final Long petId) {
      this.petId = petId;
      return this;
    }

    global String name;

    global UpdatePetWithFormRequest setName(final String name) {
      this.name = name;
      return this;
    }

    global String status;

    global UpdatePetWithFormRequest setStatus(final String status) {
      this.status = status;
      return this;
    }

  }

  global class UpdatePetWithFormResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
  }

  /**
   * Updates a pet in the store with form data
   * @param petId ID of pet that needs to be updated (required)
   * @param name Updated name of the pet (optional)
   * @param status Updated status of the pet (optional)
   * @return void
   */
  global virtual void updatePetWithForm(
    final UpdatePetWithFormRequest request
  ) {
    updatePetWithFormWithHttpInfo(request);
  }

  /**
   * Updates a pet in the store with form data
   * @param petId ID of pet that needs to be updated (required)
   * @param name Updated name of the pet (optional)
   * @param status Updated status of the pet (optional)
   * @return UpdatePetWithFormResponse
   */
  global virtual UpdatePetWithFormResponse updatePetWithFormWithHttpInfo(
    final UpdatePetWithFormRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/' + request.petId)
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('updatePetWithForm', httpResult);
    }
    final UpdatePetWithFormResponse response = new UpdatePetWithFormResponse();
    response.httpResult = httpResult;
    return response;
  }


  global class UploadFileRequest {
    global Long petId;

    global UploadFileRequest setPetId(final Long petId) {
      this.petId = petId;
      return this;
    }

    global String additionalMetadata;

    global UploadFileRequest setAdditionalMetadata(final String additionalMetadata) {
      this.additionalMetadata = additionalMetadata;
      return this;
    }

    global Blob file;

    global UploadFileRequest setFile(final Blob file) {
      this.file = file;
      return this;
    }

  }

  global class UploadFileResponse {
    global PetstoreApiHttpClient.HttpResult httpResult;
    global PetstoreApiV1ApiResponse data;
  }

  /**
   * uploads an image
   * @param petId ID of pet to update (required)
   * @param additionalMetadata Additional data to pass to server (optional)
   * @param file file to upload (optional)
   * @return PetstoreApiV1ApiResponse
   */
  global virtual PetstoreApiV1ApiResponse uploadFile(
    final UploadFileRequest request
  ) {
    return uploadFileWithHttpInfo(request).data;
  }

  /**
   * uploads an image
   * @param petId ID of pet to update (required)
   * @param additionalMetadata Additional data to pass to server (optional)
   * @param file file to upload (optional)
   * @return UploadFileResponse
   */
  global virtual UploadFileResponse uploadFileWithHttpInfo(
    final UploadFileRequest request
  ) {
    final PetstoreApiApiHttpRequestBuilder builder = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/' + request.petId + '/uploadImage')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST);
    final PetstoreApiHttpClient.HttpResult httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('uploadFile', httpResult);
    }
    final UploadFileResponse response = new UploadFileResponse();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1ApiResponse) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1ApiResponse.class);
    return response;
  }

}
