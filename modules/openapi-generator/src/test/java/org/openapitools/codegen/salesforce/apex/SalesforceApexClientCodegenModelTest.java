package org.openapitools.codegen.salesforce.apex;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.media.*;
import io.swagger.v3.parser.util.SchemaTypeUtil;
import org.openapitools.codegen.CodegenModel;
import org.openapitools.codegen.CodegenProperty;
import org.openapitools.codegen.DefaultCodegen;
import org.openapitools.codegen.TestUtils;
import org.openapitools.codegen.languages.SalesforceApexClientCodegen;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("static-method")
public class SalesforceApexClientCodegenModelTest {

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
                .addProperty("long_field", new IntegerSchema().format(SchemaTypeUtil.INTEGER64_FORMAT))
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
        final Schema enumSchema = new StringSchema()._enum(java.util.Arrays.asList("ACTIVE", "INACTIVE", "SUSPENDED"));

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
