global interface PetstoreApiAuthProvider {
    /**
    * Returns authentication headers to apply to the request.
    */
    Map<String, String> getAuthHeaders(final PetstoreApiRequestContext requestContext);
}