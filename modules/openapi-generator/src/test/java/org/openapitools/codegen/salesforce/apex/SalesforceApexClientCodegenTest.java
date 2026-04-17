package org.openapitools.codegen.salesforce.apex;

import org.openapitools.codegen.CodegenType;
import org.openapitools.codegen.languages.SalesforceApexClientCodegen;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class SalesforceApexClientCodegenTest {

    @Test(description = "generator name and type are correct")
    public void generatorMetadataTest() {
        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        Assert.assertEquals(codegen.getName(), "salesforce-apex");
        Assert.assertEquals(codegen.getTag(), CodegenType.CLIENT);
    }

    @Test(description = "api and model file folders include version directory")
    public void fileFolderTest() {
        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        codegen.additionalProperties().put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "latest.v3");
        codegen.processOpts();

        Assert.assertTrue(codegen.apiFileFolder().endsWith("api" + File.separator + "latest.v3"));
        Assert.assertTrue(codegen.modelFileFolder().endsWith("model" + File.separator + "latest.v3"));
    }

    @Test(description = "api and model class names include classPrefix and version suffix")
    public void classNameTest() {
        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        final Map<String, Object> opts = new HashMap<>();
        opts.put(SalesforceApexClientCodegen.CLASS_PREFIX, "PetstoreApi");
        opts.put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, "latest.v1");
        codegen.additionalProperties().putAll(opts);
        codegen.processOpts();

        Assert.assertEquals(codegen.toApiName("Pet"), "PetstoreApiV1PetApi");
        Assert.assertEquals(codegen.toModelName("Pet"), "PetstoreApiV1Pet");
    }

    @Test(description = "clientClassName and builderClassName are derived from classPrefix")
    public void supportingFileNamesTest() {
        final SalesforceApexClientCodegen codegen = new SalesforceApexClientCodegen();
        codegen.additionalProperties().put(SalesforceApexClientCodegen.CLASS_PREFIX, "AdsApi");
        codegen.processOpts();

        Assert.assertEquals(codegen.additionalProperties().get("clientClassName"), "AdsApiApiClient");
        Assert.assertEquals(codegen.additionalProperties().get("builderClassName"), "AdsApiApiHttpRequestBuilder");
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
        codegen.additionalProperties().put(SalesforceApexClientCodegen.SUPPRESS_WARNINGS, "PMD.AvoidGlobalModifier");
        codegen.processOpts();

        Assert.assertEquals(codegen.additionalProperties().get("hasSuppressWarnings"), true);
    }
}
