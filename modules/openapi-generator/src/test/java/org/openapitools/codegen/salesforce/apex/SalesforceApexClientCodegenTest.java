package org.openapitools.codegen.salesforce.apex;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.openapitools.codegen.CodegenModel;
import org.openapitools.codegen.CodegenOperation;
import org.openapitools.codegen.CodegenProperty;
import org.openapitools.codegen.CodegenType;
import org.openapitools.codegen.SupportingFile;
import org.openapitools.codegen.TestUtils;
import org.openapitools.codegen.languages.SalesforceApexClientCodegen;
import org.openapitools.codegen.model.OperationMap;
import org.openapitools.codegen.model.OperationsMap;
import org.testng.Assert;
import org.testng.annotations.Test;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.media.ArraySchema;
import io.swagger.v3.oas.models.media.BooleanSchema;
import io.swagger.v3.oas.models.media.DateSchema;
import io.swagger.v3.oas.models.media.DateTimeSchema;
import io.swagger.v3.oas.models.media.IntegerSchema;
import io.swagger.v3.oas.models.media.NumberSchema;
import io.swagger.v3.oas.models.media.Schema;
import io.swagger.v3.oas.models.media.StringSchema;
import io.swagger.v3.parser.util.SchemaTypeUtil;

public class SalesforceApexClientCodegenTest {
        public static class CodegenTests {
                @Test(description = "ensure the generator metadata is set correctly")
                public void itSetsTheGeneratorMetadata() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        Assert.assertEquals(codegen.getName(), "salesforce-apex");
                        Assert.assertEquals(codegen.getTag(), CodegenType.CLIENT);
                        Assert.assertEquals(codegen.getHelp(), "Generates a Salesforce Apex client library.");
                }

                @Test(description = "ensure all expected non-test client supporting files are generated")
                public void itGeneratesAllExpectedClientSupportingFiles() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION, "v1");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.GENERATE_CLIENT, "true");
                        codegen.processOpts();

                        Assert.assertEquals(codegen.supportingFiles().size(), 22);

                        final Set<String> supportingFileNames = new HashSet<>();
                        for (SupportingFile file : codegen.supportingFiles()) {
                                supportingFileNames.add(file.getDestinationFilename());
                        }

                        System.out.println(supportingFileNames);

                        // Assert common classes
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiApiException.cls"));
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiApiClient.cls"));
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiHttpClient.cls"));
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiHttpClientMock.cls"));
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiHttpRequestBuilder.cls"));
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiHttpResult.cls"));
                        Assert.assertTrue(supportingFileNames.contains("PetstoreApiInterceptor.cls"));

                }

                @Test(description = "api and model file folders include version directory")
                public void fileFolderTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION, "v3");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.OUTPUT_DIRECTORY_NAME, "latest");
                        codegen.processOpts();

                        Assert.assertTrue(codegen.apiFileFolder().endsWith("api" + File.separator + "latest.v3"));
                        Assert.assertTrue(codegen.modelFileFolder().endsWith("model" + File.separator + "latest.v3"));
                }

                @Test(description = "api and model class names include classPrefix and version suffix")
                public void classNameTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        final Map<String, Object> opts = new HashMap<>();
                        opts.put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
                        opts.put(SalesforceApexClientCodegen.API_VERSION, "V1");
                        opts.put(SalesforceApexClientCodegen.OUTPUT_DIRECTORY_NAME, "latest");
                        codegen.additionalProperties().putAll(opts);
                        codegen.processOpts();

                        Assert.assertEquals(codegen.toApiName("Pet"), "PetstoreApiV1PetApi");
                        Assert.assertEquals(codegen.toModelName("Pet"), "PetstoreApiV1Pet");
                }

                @Test(description = "clientClassName and httpRequestBuilderClassName are derived from classPrefix")
                public void supportingFileNamesTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION, "V1");
                        codegen.processOpts();

                        Assert.assertEquals(codegen.additionalProperties().get("clientClassName"),
                                        "PetstoreApiApiClient");
                        Assert.assertEquals(codegen.additionalProperties().get("httpRequestBuilderClassName"),
                                        "PetstoreApiHttpRequestBuilder");
                }

                @Test(description = "generateClient=false omits supporting files")
                public void generateClientFalseTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.GENERATE_CLIENT, "false");
                        codegen.processOpts();

                        Assert.assertTrue(codegen.supportingFiles().isEmpty());
                }

                @Test(description = "generateModels=false clears model template files")
                public void generateModelsFalseTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.GENERATE_MODELS, "false");
                        codegen.processOpts();

                        Assert.assertTrue(codegen.modelTemplateFiles().isEmpty());
                }

                @Test(description = "generateApis=false clears api template files")
                public void generateApisFalseTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.GENERATE_APIS, "false");
                        codegen.processOpts();

                        Assert.assertTrue(codegen.apiTemplateFiles().isEmpty());
                }

                @Test(description = "hasSuppressWarnings is false when suppressWarnings is empty")
                public void suppressWarningsEmptyTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.processOpts();

                        Assert.assertEquals(codegen.additionalProperties().get("hasSuppressWarnings"), false);
                }

                @Test(description = "hasSuppressWarnings is true when suppressWarnings is set")
                public void suppressWarningsSetTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.SUPPRESS_WARNINGS,
                                        "PMD.AvoidGlobalModifier");
                        codegen.processOpts();

                        Assert.assertEquals(codegen.additionalProperties().get("hasSuppressWarnings"), true);
                }
        }

        public static class ApiTests {

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
                        final OperationsMap objs = createOperationsMap("GET", "/resource/{token1}/resource/{token2}",
                                        "getResource");

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

        public static class ModelTests {
                @Test(description = "model class name includes classPrefix and versionSuffix")
                public void classNamePrefixAndVersionTest() {
                        final Map<String, Object> opts = new HashMap<>();
                        opts.put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
                        opts.put(SalesforceApexClientCodegen.API_VERSION, "V1");
                        opts.put(SalesforceApexClientCodegen.OUTPUT_DIRECTORY_NAME, "latest");

                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().putAll(opts);
                        codegen.processOpts();

                        Assert.assertEquals(codegen.toModelName("Order"), "PetstoreApiV1Order");
                        Assert.assertEquals(codegen.toModelName("Pet"), "PetstoreApiV1Pet");
                }

                @Test(description = "snake_case OAS property names are preserved as baseName; camelCase used for getters/setters")
                public void snakeCaseFieldNamesTest() {
                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION, "V1");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.OUTPUT_DIRECTORY_NAME, "latest");
                        codegen.processOpts();

                        final Schema model = new Schema()
                                        .description("a sample model")
                                        .addProperty("order_number", new StringSchema())
                                        .addRequiredItem("order_number");

                        final OpenAPI openAPI = TestUtils.createOpenAPIWithOneSchema("Order", model);
                        codegen.setOpenAPI(openAPI);

                        final CodegenModel cm = codegen.fromModel("Order", model);

                        Assert.assertEquals(cm.classname, "PetstoreApiV1Order");

                        final CodegenProperty prop = cm.vars.get(0);
                        Assert.assertEquals(prop.baseName, "order_number");
                        Assert.assertEquals(prop.name, "orderNumber");
                        Assert.assertEquals(prop.getter, "getOrderNumber");
                        Assert.assertEquals(prop.setter, "setOrderNumber");
                        Assert.assertEquals(prop.dataType, "String");
                }

                @Test(description = "OAS types map to correct Apex types")
                public void typeMappingTest() {
                        final Schema model = new Schema()
                                        .addProperty("str_field", new StringSchema())
                                        .addProperty("int_field", new IntegerSchema())
                                        .addProperty("long_field",
                                                        new IntegerSchema().format(SchemaTypeUtil.INTEGER64_FORMAT))
                                        .addProperty("bool_field", new BooleanSchema())
                                        .addProperty("date_field", new DateSchema())
                                        .addProperty("dt_field", new DateTimeSchema())
                                        .addProperty("num_field", new NumberSchema())
                                        .addProperty("arr_field", new ArraySchema().items(new StringSchema()));

                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.processOpts();

                        final OpenAPI openAPI = TestUtils.createOpenAPIWithOneSchema("TypeTestModel", model);
                        codegen.setOpenAPI(openAPI);
                        final CodegenModel cm = codegen.fromModel("TypeTestModel", model);

                        Assert.assertEquals(cm.vars.get(0).dataType, "String");
                        Assert.assertEquals(cm.vars.get(1).dataType, "Integer");
                        Assert.assertEquals(cm.vars.get(2).dataType, "Long");
                        Assert.assertEquals(cm.vars.get(3).dataType, "Boolean");
                        Assert.assertEquals(cm.vars.get(4).dataType, "Date");
                        Assert.assertEquals(cm.vars.get(5).dataType, "Datetime");
                        Assert.assertEquals(cm.vars.get(6).dataType, "Decimal");
                        Assert.assertEquals(cm.vars.get(7).dataType, "List<String>");
                }

                @Test(description = "enum schema produces isEnum=true model")
                public void enumModelTest() {
                        final Schema enumSchema = new StringSchema()
                                        ._enum(java.util.Arrays.asList("ACTIVE", "INACTIVE", "SUSPENDED"));

                        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION, "V1");
                        codegen.additionalProperties().put(SalesforceApexClientCodegen.OUTPUT_DIRECTORY_NAME, "latest");
                        codegen.processOpts();

                        final OpenAPI openAPI = TestUtils.createOpenAPIWithOneSchema("OrderStatus", enumSchema);
                        codegen.setOpenAPI(openAPI);
                        final CodegenModel cm = codegen.fromModel("OrderStatus", enumSchema);

                        Assert.assertEquals(cm.classname, "PetstoreApiV1OrderStatus");
                        Assert.assertTrue(cm.isEnum);
                }
        }
}
