package org.openapitools.codegen.options;

import org.openapitools.codegen.CodegenConstants;
import org.openapitools.codegen.languages.SalesforceApexClientCodegen;

import com.google.common.collect.ImmutableMap;

import java.util.Map;

public class SalesforceApexClientCodegenOptionsProvider implements OptionsProvider {

    public static final String CLASS_PREFIX_VALUE = "TestApi";
    public static final String API_VERSION_DIRECTORY_VALUE = "latest.v1";
    public static final String ACCESS_MODIFIER_VALUE = "global";
    public static final String SALESFORCE_API_VERSION_VALUE = "62.0";
    public static final String FLUENT_SETTERS_VALUE = "true";
    public static final String JSON_ACCESS_VALUE = "true";
    public static final String AURA_ENABLED_VALUE = "false";
    public static final String SUPPRESS_WARNINGS_VALUE = "PMD.AvoidGlobalModifier";
    public static final String GENERATE_MODELS_VALUE = "true";
    public static final String GENERATE_APIS_VALUE = "true";
    public static final String GENERATE_CLIENT_VALUE = "true";
    public static final String GENERATE_TESTS_VALUE = "true";

    @Override
    public String getLanguage() {
        return "salesforce-apex";
    }

    @Override
    public Map<String, String> createOptions() {
        return new ImmutableMap.Builder<String, String>()
                .put(SalesforceApexClientCodegen.CLASS_PREFIX, CLASS_PREFIX_VALUE)
                .put(SalesforceApexClientCodegen.API_VERSION_DIRECTORY, API_VERSION_DIRECTORY_VALUE)
                .put(SalesforceApexClientCodegen.ACCESS_MODIFIER, ACCESS_MODIFIER_VALUE)
                .put(SalesforceApexClientCodegen.SALESFORCE_API_VERSION, SALESFORCE_API_VERSION_VALUE)
                .put(SalesforceApexClientCodegen.FLUENT_SETTERS, FLUENT_SETTERS_VALUE)
                .put(SalesforceApexClientCodegen.JSON_ACCESS, JSON_ACCESS_VALUE)
                .put(SalesforceApexClientCodegen.AURA_ENABLED, AURA_ENABLED_VALUE)
                .put(SalesforceApexClientCodegen.SUPPRESS_WARNINGS, SUPPRESS_WARNINGS_VALUE)
                .put(SalesforceApexClientCodegen.GENERATE_MODELS, GENERATE_MODELS_VALUE)
                .put(SalesforceApexClientCodegen.GENERATE_APIS, GENERATE_APIS_VALUE)
                .put(SalesforceApexClientCodegen.GENERATE_CLIENT, GENERATE_CLIENT_VALUE)
                .put(SalesforceApexClientCodegen.GENERATE_TESTS, GENERATE_TESTS_VALUE)
                // DefaultCodegen base options required by AbstractOptionsTest
                .put(CodegenConstants.SORT_PARAMS_BY_REQUIRED_FLAG, "true")
                .put(CodegenConstants.SORT_MODEL_PROPERTIES_BY_REQUIRED_FLAG, "true")
                .put(CodegenConstants.ENSURE_UNIQUE_PARAMS, "true")
                .put(CodegenConstants.ALLOW_UNICODE_IDENTIFIERS, "false")
                .put(CodegenConstants.PREPEND_FORM_OR_BODY_PARAMETERS, "false")
                .put(CodegenConstants.LEGACY_DISCRIMINATOR_BEHAVIOR, "true")
                .put(CodegenConstants.DISALLOW_ADDITIONAL_PROPERTIES_IF_NOT_PRESENT, "true")
                .put(CodegenConstants.ENUM_UNKNOWN_DEFAULT_CASE, "false")
                .build();
    }

    @Override
    public boolean isServer() {
        return false;
    }
}
