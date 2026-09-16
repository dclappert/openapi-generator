final PetstoreApiApiClient apiClient = new PetstoreApiApiClient('https://petstore.swagger.io', 'v2');
final PetstoreApiV1PetApi petApi = new PetstoreApiV1PetApi(apiClient);

final PetstoreApiV1PetApi.FindPetsByStatusRequest request = new PetstoreApiV1PetApi.FindPetsByStatusRequest()
    .setStatus(new List<String>{'available'});

final PetstoreApiV1PetApi.FindPetsByStatusResponse response = petApi.findPetsByStatusWithHttpInfo(request);
final PetstoreApiHttpResult httpResult = response.httpResult;

System.debug(JSON.serializePretty(response.data));