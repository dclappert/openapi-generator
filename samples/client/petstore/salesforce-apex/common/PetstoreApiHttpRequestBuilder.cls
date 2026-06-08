global class PetstoreApiHttpRequestBuilder {
  // DELETE is a reserved keyword in Apex — use DEL and map to 'DELETE' in build()
  global enum HttpMethod { GET, POST, PUT, PATCH, DEL }

  global final String operationId { get; private set; }
  global final Map<String, String> headerParams { 
    get { 
      return new Map<String, String>(this.headerParams); 
    }
    private set; 
  }
  global final Map<String, String> queryParams { 
    get { 
      return new Map<String, String>(this.queryParams); 
    }
    private set; 
  }
  global String body { get; private set; }
  global String endpoint { get; private set; }
  global HttpMethod method { get; private set; }

  global PetstoreApiHttpRequestBuilder(final String operationId) {
    this.operationId = operationId;
    this.headerParams = new Map<String, String>();
    this.queryParams = new Map<String, String>();
  }
  
  global PetstoreApiHttpRequestBuilder setEndpoint(final String endpoint) {
    this.endpoint = endpoint;
    return this;
  }

  global PetstoreApiHttpRequestBuilder setMethod(final HttpMethod method) {
    this.method = method;
    return this;
  }

  global PetstoreApiHttpRequestBuilder setBody(final String body) {
    this.body = body;
    return this;
  }

  global PetstoreApiHttpRequestBuilder addQueryParameter(final String key, final String value) {
    this.queryParams.put(key, value);
    return this;
  }

  global PetstoreApiHttpRequestBuilder addHeader(final String key, final String value) {
    this.headerParams.put(key, value);
    return this;
  }
 
  // Intended for internal use by the generated API client, not for direct use by consumers
  public HttpRequest build(final String baseUrl, final String version) {
    final String url = baseUrl + '/' + version + '/' + this.endpoint;
    if (!this.queryParams.isEmpty()) {
      final List<String> parts = new List<String>();
      for (String key : this.queryParams.keySet()) {
        parts.add(key + '=' + EncodingUtil.urlEncode(this.queryParams.get(key), 'UTF-8'));
      }
      url += '?' + String.join(parts, '&');
    }

    final HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod(this.method == HttpMethod.DEL ? 'DELETE' : this.method.name());
    req.setHeader('Content-Type', 'application/json');
    req.setHeader('Accept', 'application/json');
    for (String headerName : this.headerParams.keySet()) {
      req.setHeader(headerName, this.headerParams.get(headerName));
    }
    
    if (this.body != null) {
      req.setBody(this.body);
    }
    return req;
  }
}
