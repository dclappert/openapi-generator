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
        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        final Map<String, Object> opts = new HashMap<>();
        opts.put(SalesforceApexClientCodegen.CLASS_PREFIX, "AdsApi");
        opts.put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "latest.v3");
        codegen.additionalProperties().putAll(opts);
        codegen.processOpts();

        Assert.assertEquals(codegen.toModelName("Reservation"), "AdsApiV3Reservation");
        Assert.assertEquals(codegen.toModelName("CreateReservationRequest"), "AdsApiV3CreateReservationRequest");
    }

    @Test(description = "versionSuffix is derived from apiVersionDirectory")
    public void versionSuffixDerivationTest() {
        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        final Map<String, Object> opts = new HashMap<>();
        opts.put(SalesforceApexClientCodegen.CLASS_PREFIX, "MyApi");
        opts.put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "v2");
        codegen.additionalProperties().putAll(opts);
        codegen.processOpts();

        Assert.assertEquals(codegen.toModelName("Pet"), "MyApiV2Pet");

        final SalesforceApexClientCodegen codegen2 = new SalesforceApexClientCodegen();
        final Map<String, Object> opts2 = new HashMap<>();
        opts2.put(SalesforceApexClientCodegen.CLASS_PREFIX, "MyApi");
        opts2.put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "latest.v2");
        codegen2.additionalProperties().putAll(opts2);
        codegen2.processOpts();

        Assert.assertEquals(codegen2.toModelName("Pet"), "MyApiV2Pet");
    }

    @Test(description = "snake_case OAS property names are preserved as baseName; camelCase used for getters/setters")
    public void snakeCaseFieldNamesTest() {
        final Schema model = new Schema()
                .description("a sample model")
                .addProperty("ad_account_id", new StringSchema())
                .addProperty("start_date", new DateTimeSchema())
                .addRequiredItem("ad_account_id");

        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "AdsApi");
        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "v3");
        codegen.processOpts();

        final OpenAPI openAPI = TestUtils.createOpenAPIWithOneSchema("AudienceEstimateRequest", model);
        codegen.setOpenAPI(openAPI);
        final CodegenModel cm = codegen.fromModel("AudienceEstimateRequest", model);

        Assert.assertEquals(cm.classname, "AdsApiV3AudienceEstimateRequest");

        final CodegenProperty prop = cm.vars.get(0);
        Assert.assertEquals(prop.baseName, "ad_account_id");
        Assert.assertEquals(prop.name, "adAccountId");
        Assert.assertEquals(prop.getter, "getAdAccountId");
        Assert.assertEquals(prop.setter, "setAdAccountId");
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
        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "AdsApi");
        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "v3");
        codegen.processOpts();

        final OpenAPI openAPI = TestUtils.createOpenAPIWithOneSchema("AdAccountStatus", enumSchema);
        codegen.setOpenAPI(openAPI);
        final CodegenModel cm = codegen.fromModel("AdAccountStatus", enumSchema);

        Assert.assertEquals(cm.classname, "AdsApiV3AdAccountStatus");
        Assert.assertTrue(cm.isEnum);
    }
}
