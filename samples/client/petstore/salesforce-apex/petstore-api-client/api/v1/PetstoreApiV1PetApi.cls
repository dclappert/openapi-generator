@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
global virtual class PetstoreApiV1PetApi {
  private PetstoreApiApiClient client;

  global PetstoreApiV1PetApi(final PetstoreApiApiClient client) {
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
    global PetstoreApiV1Pet petstoreApiV1Pet;

    global  (final PetstoreApiV1Pet petstoreApiV1Pet) {
      this.petstoreApiV1Pet = petstoreApiV1Pet;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global PetstoreApiV1Pet data;
  }

  /**
   * Add a new pet to the store
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return PetstoreApiV1Pet
   */
  global virtual PetstoreApiV1Pet addPet(
    final  request
  ) {
    return addPetWithHttpInfo(request).data;
  }

  /**
   * Add a new pet to the store
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return 
   */
  global virtual  addPetWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1Pet));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('addPet', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Pet) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Pet.class);
    return response;
  }

  global class  {
    global Long petId;
    global String apiKey;

    global  (final Long petId) {
      this.petId = petId;
      return this;
    }

    global  (final String apiKey) {
      this.apiKey = apiKey;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Deletes a pet
   * @param petId Pet id to delete (required)
   * @param apiKey  (optional)
   * @return void
   */
  global virtual void deletePet(
    final  request
  ) {
    deletePetWithHttpInfo(request);
  }

  /**
   * Deletes a pet
   * @param petId Pet id to delete (required)
   * @param apiKey  (optional)
   * @return 
   */
  global virtual  deletePetWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('deletePet', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global List<String> status;

    global  (final List<String> status) {
      this.status = status;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global List<PetstoreApiV1Pet> data;
  }

  /**
   * Finds Pets by status
   * @param status Status values that need to be considered for filter (required)
   * @return List<PetstoreApiV1Pet>
   */
  global virtual List<PetstoreApiV1Pet> findPetsByStatus(
    final  request
  ) {
    return findPetsByStatusWithHttpInfo(request).data;
  }

  /**
   * Finds Pets by status
   * @param status Status values that need to be considered for filter (required)
   * @return 
   */
  global virtual  findPetsByStatusWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    if (request.status != null && !request.status.isEmpty()) {
      final List<String> statusStrs = new List<String>();
      for (String item : request.status) {
        statusStrs.add(String.valueOf(item));
      }
      builder.addQueryParameter('status', String.join(statusStrs, ','));
    }
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('findPetsByStatus', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (List<PetstoreApiV1Pet>) JSON.deserialize(httpResult.response.getBody(), List<PetstoreApiV1Pet>.class);
    return response;
  }

  global class  {
    global List<String> tags;

    global  (final List<String> tags) {
      this.tags = tags;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global List<PetstoreApiV1Pet> data;
  }

  /**
   * Finds Pets by tags
   * @param tags Tags to filter by (required)
   * @return List<PetstoreApiV1Pet>
   */
  global virtual List<PetstoreApiV1Pet> findPetsByTags(
    final  request
  ) {
    return findPetsByTagsWithHttpInfo(request).data;
  }

  /**
   * Finds Pets by tags
   * @param tags Tags to filter by (required)
   * @return 
   */
  global virtual  findPetsByTagsWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    if (request.tags != null && !request.tags.isEmpty()) {
      final List<String> tagsStrs = new List<String>();
      for (String item : request.tags) {
        tagsStrs.add(String.valueOf(item));
      }
      builder.addQueryParameter('tags', String.join(tagsStrs, ','));
    }
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('findPetsByTags', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (List<PetstoreApiV1Pet>) JSON.deserialize(httpResult.response.getBody(), List<PetstoreApiV1Pet>.class);
    return response;
  }

  global class  {
    global Long petId;

    global  (final Long petId) {
      this.petId = petId;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global PetstoreApiV1Pet data;
  }

  /**
   * Find pet by ID
   * @param petId ID of pet to return (required)
   * @return PetstoreApiV1Pet
   */
  global virtual PetstoreApiV1Pet getPetById(
    final  request
  ) {
    return getPetByIdWithHttpInfo(request).data;
  }

  /**
   * Find pet by ID
   * @param petId ID of pet to return (required)
   * @return 
   */
  global virtual  getPetByIdWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('getPetById', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Pet) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Pet.class);
    return response;
  }

  global class  {
    global PetstoreApiV1Pet petstoreApiV1Pet;

    global  (final PetstoreApiV1Pet petstoreApiV1Pet) {
      this.petstoreApiV1Pet = petstoreApiV1Pet;
      return this;
    }
  }

  global class  {
    global  httpResult;
    global PetstoreApiV1Pet data;
  }

  /**
   * Update an existing pet
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return PetstoreApiV1Pet
   */
  global virtual PetstoreApiV1Pet updatePet(
    final  request
  ) {
    return updatePetWithHttpInfo(request).data;
  }

  /**
   * Update an existing pet
   * @param petstoreApiV1Pet Pet object that needs to be added to the store (required)
   * @return 
   */
  global virtual  updatePetWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    builder.setBody(JSON.serialize(request.petstoreApiV1Pet));
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('updatePet', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1Pet) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1Pet.class);
    return response;
  }

  global class  {
    global Long petId;
    global String name;
    global String status;

    global  (final Long petId) {
      this.petId = petId;
      return this;
    }

    global  (final String name) {
      this.name = name;
      return this;
    }

    global  (final String status) {
      this.status = status;
      return this;
    }
  }

  global class  {
    global  httpResult;
  }

  /**
   * Updates a pet in the store with form data
   * @param petId ID of pet that needs to be updated (required)
   * @param name Updated name of the pet (optional)
   * @param status Updated status of the pet (optional)
   * @return void
   */
  global virtual void updatePetWithForm(
    final  request
  ) {
    updatePetWithFormWithHttpInfo(request);
  }

  /**
   * Updates a pet in the store with form data
   * @param petId ID of pet that needs to be updated (required)
   * @param name Updated name of the pet (optional)
   * @param status Updated status of the pet (optional)
   * @return 
   */
  global virtual  updatePetWithFormWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('updatePetWithForm', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    return response;
  }

  global class  {
    global Long petId;
    global String additionalMetadata;
    global Blob file;

    global  (final Long petId) {
      this.petId = petId;
      return this;
    }

    global  (final String additionalMetadata) {
      this.additionalMetadata = additionalMetadata;
      return this;
    }

    global  (final Blob file) {
      this.file = file;
      return this;
    }
  }

  global class  {
    global  httpResult;
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
    final  request
  ) {
    return uploadFileWithHttpInfo(request).data;
  }

  /**
   * uploads an image
   * @param petId ID of pet to update (required)
   * @param additionalMetadata Additional data to pass to server (optional)
   * @param file file to upload (optional)
   * @return 
   */
  global virtual  uploadFileWithHttpInfo(
    final  request
  ) {
    final  builder = new ()
      .setEndpoint()
      .setMethod(.HttpMethod.);
    final  httpResult = this.client.send(builder);
    if (httpResult.response.getStatusCode() / 100 != 2) {
      throw buildApiException('uploadFile', httpResult);
    }
    final  response = new ();
    response.httpResult = httpResult;
    response.data = (PetstoreApiV1ApiResponse) JSON.deserialize(httpResult.response.getBody(), PetstoreApiV1ApiResponse.class);
    return response;
  }

}
