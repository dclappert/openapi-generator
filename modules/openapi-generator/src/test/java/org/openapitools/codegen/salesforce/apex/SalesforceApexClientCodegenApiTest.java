package org.openapitools.codegen.salesforce.apex;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.media.*;
import io.swagger.v3.parser.util.SchemaTypeUtil;
import org.openapitools.codegen.CodegenModel;
import org.openapitools.codegen.CodegenOperation;
import org.openapitools.codegen.CodegenProperty;
import org.openapitools.codegen.DefaultCodegen;
import org.openapitools.codegen.TestUtils;
import org.openapitools.codegen.languages.SalesforceApexClientCodegen;
import org.openapitools.codegen.model.OperationMap;
import org.openapitools.codegen.model.OperationsMap;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

@SuppressWarnings("static-method")
public class SalesforceApexClientCodegenApiTest {
    @Test(description = "converts path with parameter as initial segment to apex http request endpoint without leading slash")
    public void itConvertsPathWithParameterAsInitialSegmentToApexHttpRequestEndpointWithoutLeadingSlash() {
        final OperationsMap objs = createOperationsMap("GET", "{token1}/resource", "getResource");

        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        codegen.postProcessOperationsWithModels(objs,
                new ArrayList<>());

        final CodegenOperation operation = objs.getOperations().getOperation().get(0);
        Assert.assertEquals(operation.vendorExtensions.get("x-apex-http-request-endpoint"),
                "request.token1 + '/resource'");
    }

    @Test(description = "converts path with parameter as initial segment to apex http request endpoint with leading slash")
    public void itConvertsPathWithParameterAsInitialSegmentToApexHttpRequestEndpointWithLeadingSlash() {
        final OperationsMap objs = createOperationsMap("GET", "/{token1}/resource", "getResource");

        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        codegen.postProcessOperationsWithModels(objs,
                new ArrayList<>());

        final CodegenOperation operation = objs.getOperations().getOperation().get(0);
        Assert.assertEquals(operation.vendorExtensions.get("x-apex-http-request-endpoint"),
                "'/' + request.token1 + '/resource'");
    }

    @Test(description = "converts path with parameter as last segment to apex http request endpoint")
    public void itConvertsPathWithParameterAsLastSegmentToApexHttpRequestEndpoint() {
        final OperationsMap objs = createOperationsMap("GET", "/resource/{token1}/resource/{token2}", "getResource");

        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        codegen.postProcessOperationsWithModels(objs,
                new ArrayList<>());

        final CodegenOperation operation = objs.getOperations().getOperation().get(0);
        Assert.assertEquals(operation.vendorExtensions.get("x-apex-http-request-endpoint"),
                "'/resource/' + request.token1 + '/resource/' + request.token2");
    }

    private static OperationsMap createOperationsMap(final String httpMethod, final String path,
            final String operationId) {
        final CodegenOperation op = new CodegenOperation();
        op.httpMethod = httpMethod;
        op.operationId = operationId;
        op.path = path;
        op.allParams = new ArrayList<>();

        final OperationMap operationMap = new OperationMap();
        operationMap.setOperation(op);

        final OperationsMap objs = new OperationsMap();
        objs.setOperation(operationMap);
        return objs;
    }
}
