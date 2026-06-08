package org.openapitools.codegen.languages;

import io.swagger.v3.oas.models.media.Schema;
import org.apache.commons.lang3.StringUtils;
import org.openapitools.codegen.*;
import org.openapitools.codegen.model.ModelMap;
import org.openapitools.codegen.model.ModelsMap;
import org.openapitools.codegen.model.OperationsMap;
import org.openapitools.codegen.utils.ModelUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.openapitools.codegen.utils.CamelizeOption.LOWERCASE_FIRST_LETTER;
import static org.openapitools.codegen.utils.StringUtils.camelize;

public class SalesforceApexClientCodegen extends DefaultCodegen {

    // Additional properties keys
    public static final String ACCESS_MODIFIER = "accessModifier";
    public static final String API_VERSION = "apiVersion";
    public static final String AURA_ENABLED = "auraEnabled";
    public static final String CLASS_PREFIX = "classPrefix";
    public static final String FLUENT_SETTERS = "fluentSetters";
    public static final String GENERATE_APIS = "generateApis";
    public static final String GENERATE_CLIENT = "generateClient";
    public static final String GENERATE_MODELS = "generateModels";
    public static final String GENERATE_TESTS = "generateTests";
    public static final String JSON_ACCESS = "jsonAccess";
    public static final String OUTPUT_DIRECTORY_NAME = "outputDirectoryName";
    public static final String SALESFORCE_API_VERSION = "salesforceApiVersion";
    public static final String SUPPRESS_WARNINGS = "suppressWarnings";

    // Default values for additional properties
    private boolean auraEnabled = false;
    private boolean fluentSetters = true;
    private boolean generateApis = true;
    private boolean generateClient = true;
    private boolean generateModels = true;
    private boolean generateTests = true;
    private boolean jsonAccess = true;
    private String accessModifier = "global";
    private String apiVersion = "";
    private String classPrefix = "";
    private String outputDirectoryName = "";
    private String salesforceApiVersion = "67.0";
    private String suppressWarnings = "";

    private final Logger LOGGER = LoggerFactory.getLogger(SalesforceApexClientCodegen.class);

    @Override
    public CodegenType getTag() {
        return CodegenType.CLIENT;
    }

    @Override
    public String getName() {
        return "salesforce-apex";
    }

    @Override
    public String getHelp() {
        return "Generates a Salesforce Apex client library.";
    }

    public SalesforceApexClientCodegen() {
        super();

        outputFolder = "generated-code" + File.separator + "salesforce-apex";
        embeddedTemplateDir = templateDir = "salesforce-apex";

        modelTemplateFiles.put("model.mustache", ".cls");
        modelTemplateFiles.put("cls-meta.mustache", ".cls-meta.xml");

        apiTemplateFiles.put("api.mustache", ".cls");
        apiTemplateFiles.put("cls-meta.mustache", ".cls-meta.xml");

        // OAS → Apex type mappings
        typeMapping.clear();
        typeMapping.put("any", "Object");
        typeMapping.put("AnyType", "Object");
        typeMapping.put("array", "List");
        typeMapping.put("binary", "Blob");
        typeMapping.put("boolean", "Boolean");
        typeMapping.put("ByteArray", "Blob");
        typeMapping.put("date-time", "Datetime");
        typeMapping.put("date", "Date");
        typeMapping.put("DateTime", "Datetime");
        typeMapping.put("decimal", "Decimal");
        typeMapping.put("double", "Decimal");
        typeMapping.put("file", "Blob");
        typeMapping.put("float", "Decimal");
        typeMapping.put("integer", "Integer");
        typeMapping.put("List", "List");
        typeMapping.put("long", "Long");
        typeMapping.put("map", "Map");
        typeMapping.put("number", "Decimal");
        typeMapping.put("object", "Map<String, Object>");
        typeMapping.put("set", "List");
        typeMapping.put("string", "String");
        typeMapping.put("URI", "String");
        typeMapping.put("UUID", "UUID");

        instantiationTypes.put("array", "List");
        instantiationTypes.put("map", "Map");

        languageSpecificPrimitives.clear();
        languageSpecificPrimitives.add("Blob");
        languageSpecificPrimitives.add("Boolean");
        languageSpecificPrimitives.add("Date");
        languageSpecificPrimitives.add("Datetime");
        languageSpecificPrimitives.add("Decimal");
        languageSpecificPrimitives.add("Double");
        languageSpecificPrimitives.add("Id");
        languageSpecificPrimitives.add("Integer");
        languageSpecificPrimitives.add("Long");
        languageSpecificPrimitives.add("Object");
        languageSpecificPrimitives.add("String");

        // Derived from:
        // https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_reserved_words.htm
        setReservedWordsLowerCase(Arrays.asList(
                "abstract", "activate", "and", "any", "array", "as", "asc", "autonomous", "begin", "bigdecimal", "blob",
                "boolean", "break", "bulk", "by", "byte", "case", "cast", "catch", "char", "class", "collect", "commit",
                "const", "continue", "currency", "date", "datetime", "decimal", "default", "delete", "desc", "do",
                "double", "else", "end", "enum", "exception", "exit", "export", "extends", "false", "final", "finally",
                "float", "for", "from", "global", "goto", "group", "having", "hint", "if", "implements", "import", "in",
                "inner", "insert", "instanceof", "int", "integer", "interface", "into", "join", "like", "limit", "list",
                "long", "loop", "map", "merge", "new", "not", "null", "nulls", "number", "object", "of", "on", "or",
                "outer", "override", "package", "parallel", "pragma", "private", "protected", "public", "retrieve",
                "return", "rollback", "select", "set", "short", "sObject", "sort", "static", "string", "super",
                "switch", "synchronized", "system", "testmethod", "then", "this", "throw", "time", "transaction",
                "trigger", "true", "try", "undelete", "update", "upsert", "using", "virtual", "void", "webservice",
                "when", "where", "while"));

        cliOptions.add(CliOption.newBoolean(AURA_ENABLED, "Add @AuraEnabled to each model field.")
                .defaultValue(Boolean.toString(auraEnabled)));
        cliOptions.add(CliOption.newBoolean(FLUENT_SETTERS, "Generate fluent setters returning this (builder pattern).")
                .defaultValue(Boolean.toString(fluentSetters)));
        cliOptions.add(CliOption.newBoolean(GENERATE_APIS, "Generate API classes.")
                .defaultValue(Boolean.toString(generateApis)));
        cliOptions.add(
                CliOption.newBoolean(GENERATE_CLIENT, "Generate ApiClient and HttpRequestBuilder supporting files.")
                        .defaultValue(Boolean.toString(generateClient)));
        cliOptions.add(CliOption.newBoolean(GENERATE_MODELS, "Generate model classes.")
                .defaultValue(Boolean.toString(generateModels)));
        cliOptions.add(CliOption.newBoolean(GENERATE_TESTS, "Generate Apex test classes alongside each source class.")
                .defaultValue(Boolean.toString(generateTests)));
        cliOptions.add(CliOption
                .newBoolean(JSON_ACCESS,
                        "Add @JsonAccess(serializable='always' deserializable='always') to model classes.")
                .defaultValue(Boolean.toString(jsonAccess)));
        cliOptions.add(CliOption
                .newString(ACCESS_MODIFIER, "Access modifier for generated classes and fields (global or public).")
                .defaultValue(accessModifier));
        cliOptions.add(
                CliOption.newString(API_VERSION,
                        "Optional API version to append to generated class names (e.g. PetshopApiV1) and output directory (e.g. /api/development.v1/).")
                        .defaultValue(apiVersion));
        cliOptions.add(
                CliOption.newString(CLASS_PREFIX, "Prefix for all generated class names (highly recommended).")
                        .defaultValue(classPrefix));
        cliOptions.add(CliOption.newString(OUTPUT_DIRECTORY_NAME, "Output directory name (e.g. development).")
                .defaultValue(outputDirectoryName));
        cliOptions.add(CliOption.newString(SALESFORCE_API_VERSION, "Salesforce API version for cls-meta.xml.")
                .defaultValue(salesforceApiVersion));
        cliOptions.add(
                CliOption.newString(SUPPRESS_WARNINGS, "PMD suppression string for @SuppressWarnings (empty = omit).")
                        .defaultValue(suppressWarnings));
    }

    @Override
    public void processOpts() {
        super.processOpts();

        if (additionalProperties.containsKey(CLASS_PREFIX)) {
            classPrefix = (String) additionalProperties.get(CLASS_PREFIX);
        }
        additionalProperties.put(CLASS_PREFIX, classPrefix);

        if (additionalProperties.containsKey(API_VERSION)) {
            apiVersion = (String) additionalProperties.get(API_VERSION);
        }
        additionalProperties.put(API_VERSION, apiVersion);

        if (additionalProperties.containsKey(OUTPUT_DIRECTORY_NAME)) {
            outputDirectoryName = (String) additionalProperties.get(OUTPUT_DIRECTORY_NAME);
        }
        additionalProperties.put(OUTPUT_DIRECTORY_NAME, outputDirectoryName);

        if (additionalProperties.containsKey(ACCESS_MODIFIER)) {
            accessModifier = (String) additionalProperties.get(ACCESS_MODIFIER);
        }
        additionalProperties.put(ACCESS_MODIFIER, accessModifier);

        if (additionalProperties.containsKey(SALESFORCE_API_VERSION)) {
            salesforceApiVersion = (String) additionalProperties.get(SALESFORCE_API_VERSION);
        }
        additionalProperties.put(SALESFORCE_API_VERSION, salesforceApiVersion);

        if (additionalProperties.containsKey(FLUENT_SETTERS)) {
            fluentSetters = Boolean.parseBoolean(additionalProperties.get(FLUENT_SETTERS).toString());
        }
        additionalProperties.put(FLUENT_SETTERS, fluentSetters);

        if (additionalProperties.containsKey(JSON_ACCESS)) {
            jsonAccess = Boolean.parseBoolean(additionalProperties.get(JSON_ACCESS).toString());
        }
        additionalProperties.put(JSON_ACCESS, jsonAccess);

        if (additionalProperties.containsKey(AURA_ENABLED)) {
            auraEnabled = Boolean.parseBoolean(additionalProperties.get(AURA_ENABLED).toString());
        }
        additionalProperties.put(AURA_ENABLED, auraEnabled);

        if (additionalProperties.containsKey(SUPPRESS_WARNINGS)) {
            suppressWarnings = (String) additionalProperties.get(SUPPRESS_WARNINGS);
        }
        additionalProperties.put(SUPPRESS_WARNINGS, suppressWarnings);
        additionalProperties.put("hasSuppressWarnings", !suppressWarnings.isEmpty());

        if (additionalProperties.containsKey(GENERATE_MODELS)) {
            generateModels = Boolean.parseBoolean(additionalProperties.get(GENERATE_MODELS).toString());
        }
        if (!generateModels) {
            modelTemplateFiles.clear();
        }

        if (additionalProperties.containsKey(GENERATE_APIS)) {
            generateApis = Boolean.parseBoolean(additionalProperties.get(GENERATE_APIS).toString());
        }
        if (!generateApis) {
            apiTemplateFiles.clear();
        }

        if (additionalProperties.containsKey(GENERATE_CLIENT)) {
            generateClient = Boolean.parseBoolean(additionalProperties.get(GENERATE_CLIENT).toString());
        }

        if (additionalProperties.containsKey(GENERATE_TESTS)) {
            generateTests = Boolean.parseBoolean(additionalProperties.get(GENERATE_TESTS).toString());
        }

        final String apiExceptionClassName = classPrefix + "ApiException";
        final String clientClassName = classPrefix + "ApiClient";
        final String httpClientClassName = classPrefix + "HttpClient";
        final String httpClientMockClassName = classPrefix + "HttpClientMock";
        final String httpRequestBuilderClassName = classPrefix + "HttpRequestBuilder";
        final String httpResultClassName = classPrefix + "HttpResult";
        final String interceptorClassName = classPrefix + "Interceptor";
        additionalProperties.put("apiExceptionClassName", apiExceptionClassName);
        additionalProperties.put("clientClassName", clientClassName);
        additionalProperties.put("httpClientClassName", httpClientClassName);
        additionalProperties.put("httpClientMockClassName", httpClientMockClassName);
        additionalProperties.put("httpRequestBuilderClassName", httpRequestBuilderClassName);
        additionalProperties.put("httpResultClassName", httpResultClassName);
        additionalProperties.put("interceptorClassName", interceptorClassName);

        if (generateClient) {
            // ApiException class
            supportingFiles.add(new SupportingFile("apiException.mustache", "common", apiExceptionClassName + ".cls"));
            supportingFiles
                    .add(new SupportingFile("cls-meta.mustache", "common", apiExceptionClassName + ".cls-meta.xml"));

            // ApiClient class
            supportingFiles.add(new SupportingFile("apiClient.mustache", "common", clientClassName + ".cls"));
            supportingFiles.add(new SupportingFile("cls-meta.mustache", "common", clientClassName + ".cls-meta.xml"));

            // HttpClient class
            supportingFiles.add(new SupportingFile("httpClient.mustache", "common", httpClientClassName + ".cls"));
            supportingFiles
                    .add(new SupportingFile("cls-meta.mustache", "common", httpClientClassName + ".cls-meta.xml"));

            // HttpRequestBuilder class
            supportingFiles.add(
                    new SupportingFile("httpRequestBuilder.mustache", "common", httpRequestBuilderClassName + ".cls"));
            supportingFiles.add(
                    new SupportingFile("cls-meta.mustache", "common", httpRequestBuilderClassName + ".cls-meta.xml"));

            // HttpResult class
            supportingFiles.add(new SupportingFile("httpResult.mustache", "common", httpResultClassName + ".cls"));
            supportingFiles
                    .add(new SupportingFile("cls-meta.mustache", "common", httpResultClassName + ".cls-meta.xml"));

            // Interceptor interface
            supportingFiles.add(new SupportingFile("interceptor.mustache", "common", interceptorClassName + ".cls"));
            supportingFiles
                    .add(new SupportingFile("cls-meta.mustache", "common", interceptorClassName + ".cls-meta.xml"));
        }

        if (generateTests) {
            if (generateModels) {
                modelTemplateFiles.put("modelTest.mustache", "Test.cls");
                modelTemplateFiles.put("clsMetaTest.mustache", "Test.cls-meta.xml");
            }
            if (generateApis) {
                apiTemplateFiles.put("apiTest.mustache", "Test.cls");
                apiTemplateFiles.put("clsMetaTest.mustache", "Test.cls-meta.xml");
            }
            if (generateClient) {
                supportingFiles
                        .add(new SupportingFile("httpClientMock.mustache", "common", httpClientMockClassName + ".cls"));
                supportingFiles.add(
                        new SupportingFile("cls-meta.mustache", "common", httpClientMockClassName + ".cls-meta.xml"));

                supportingFiles
                        .add(new SupportingFile("apiClientTest.mustache", "common", clientClassName + "Test.cls"));
                supportingFiles
                        .add(new SupportingFile("cls-meta.mustache", "common", clientClassName + "Test.cls-meta.xml"));

                supportingFiles
                        .add(new SupportingFile("httpClientTest.mustache", "common", httpClientClassName + "Test.cls"));
                supportingFiles.add(
                        new SupportingFile("cls-meta.mustache", "common", httpClientClassName + "Test.cls-meta.xml"));

                supportingFiles.add(
                        new SupportingFile("apiExceptionTest.mustache", "common", apiExceptionClassName + "Test.cls"));
                supportingFiles.add(
                        new SupportingFile("cls-meta.mustache", "common", apiExceptionClassName + "Test.cls-meta.xml"));

                supportingFiles.add(
                        new SupportingFile("httpRequestBuilderTest.mustache", "common",
                                httpRequestBuilderClassName + "Test.cls"));
                supportingFiles
                        .add(new SupportingFile("cls-meta.mustache", "common",
                                httpRequestBuilderClassName + "Test.cls-meta.xml"));
            }
        }
    }

    @Override
    public String toModelName(String name) {
        final String sanitized = sanitizeName(name);
        final String camelized = camelize(sanitized);
        return classPrefix + apiVersion + camelized;
    }

    @Override
    public String toModelFilename(String name) {
        return toModelName(name);
    }

    @Override
    public String toApiName(String name) {
        final String camelized = camelize(sanitizeName(name));
        return classPrefix + apiVersion + camelized + "Api";
    }

    @Override
    public String toApiFilename(String name) {
        return toApiName(name);
    }

    @Override
    public String apiFileFolder() {
        return outputFolder + File.separator + "api" + File.separator + outputDirectoryName
                + (apiVersion.isEmpty() ? "" : "." + apiVersion.toLowerCase(Locale.ROOT));
    }

    @Override
    public String modelFileFolder() {
        return outputFolder + File.separator + "model" + File.separator + outputDirectoryName
                + (apiVersion.isEmpty() ? "" : "." + apiVersion.toLowerCase(Locale.ROOT));
    }

    @Override
    public String apiTestFileFolder() {
        return outputFolder + File.separator + "api" + File.separator + outputDirectoryName
                + (apiVersion.isEmpty() ? "" : "." + apiVersion.toLowerCase(Locale.ROOT));
    }

    @Override
    public String modelTestFileFolder() {
        return outputFolder + File.separator + "model" + File.separator + outputDirectoryName
                + (apiVersion.isEmpty() ? "" : "." + apiVersion.toLowerCase(Locale.ROOT));
    }

    @Override
    public String escapeReservedWord(String name) {
        if (this.reservedWordsMappings().containsKey(name)) {
            return this.reservedWordsMappings().get(name);
        }
        return "x_" + name;
    }

    @Override
    public String getTypeDeclaration(Schema p) {
        if (ModelUtils.isArraySchema(p)) {
            Schema inner = ModelUtils.getSchemaItems(p);
            if (inner == null) {
                return "List<Object>";
            }
            return "List<" + getTypeDeclaration(inner) + ">";
        } else if (ModelUtils.isMapSchema(p)) {
            Schema inner = ModelUtils.getAdditionalProperties(p);
            if (inner == null) {
                return "Map<String, Object>";
            }
            return "Map<String, " + getTypeDeclaration(inner) + ">";
        }
        return super.getTypeDeclaration(p);
    }

    @Override
    public String toDefaultValue(Schema p) {
        return "null";
    }

    @Override
    public String getSchemaType(Schema p) {
        String schemaType = super.getSchemaType(p);
        if (typeMapping.containsKey(schemaType)) {
            return typeMapping.get(schemaType);
        }
        return toModelName(schemaType);
    }

    @Override
    public ModelsMap postProcessModels(ModelsMap objs) {
        for (ModelMap modelMap : objs.getModels()) {
            CodegenModel model = modelMap.getModel();
            for (CodegenProperty var : model.vars) {
                var.vendorExtensions.put("x-apex-operation-req-class-var-mock-value",
                        toApexOperationReqClassVarMockValue(var));
            }
        }
        return super.postProcessModels(objs);
    }

    private static String toApexOperationReqClassVarMockValue(IJsonSchemaValidationProperties p) {
        if (p.getIsArray() || p.getIsMap()) {
            return "new " + p.getDataType() + "()";
        }
        if (p.getIsString()) {
            return "'x'";
        }
        if (p.getIsInteger()) {
            return "1";
        }
        if (p.getIsLong()) {
            return "1L";
        }
        if (p.getIsNumber() || p.getIsFloat() || p.getIsDouble() || p.getIsDecimal()) {
            return "1.0";
        }
        if (p.getIsBoolean()) {
            return "true";
        }
        if (p.getIsDate()) {
            return "Date.today()";
        }
        if (p.getIsDateTime()) {
            return "Datetime.now()";
        }
        if (p.getIsByteArray() || p.getIsBinary()) {
            return "Blob.valueOf('x')";
        }
        if (p.getIsEnum()) {
            return p.getDataType() + ".values()[0]";
        }

        // Custom models support no-arg construction in Apex.
        return "new " + p.getDataType() + "()";
    }

    @Override
    public OperationsMap postProcessOperationsWithModels(OperationsMap objs, List<ModelMap> allModels) {
        final String clientClassName = classPrefix + "ApiClient";
        final String httpRequestBuilderClassName = classPrefix + "ApiHttpRequestBuilder";
        objs.put("clientClassName", clientClassName);
        objs.put("httpRequestBuilderClassName", httpRequestBuilderClassName);

        List<CodegenOperation> ops = objs.getOperations().getOperation();
        for (CodegenOperation op : ops) {
            setApexHttpRequestVendorExtensions(op);
            setOperationMethodRequestDtoVendorExtensions(op);
        }

        return super.postProcessOperationsWithModels(objs, allModels);
    }

    @Override
    public String toOperationId(String operationId) {
        if (StringUtils.isEmpty(operationId)) {
            throw new RuntimeException("Empty method name (operationId) not allowed");
        }
        operationId = camelize(sanitizeName(operationId), LOWERCASE_FIRST_LETTER);
        if (isReservedWord(operationId)) {
            String newId = camelize("call_" + operationId, LOWERCASE_FIRST_LETTER);
            LOGGER.warn("{} (reserved word) cannot be used as method name. Renamed to {}", operationId, newId);
            return newId;
        }
        return operationId;
    }

    @Override
    public String toVarName(String name) {
        name = sanitizeName(name);
        if (name.toLowerCase(Locale.ROOT).matches("^_*class$")) {
            return "propertyClass";
        }
        if ("_".equals(name)) {
            return "_u";
        }
        if (name.matches("^[A-Z_]*$")) {
            if (isReservedWord(name)) {
                return escapeReservedWord(name);
            }
            return name;
        }
        name = camelize(name, LOWERCASE_FIRST_LETTER);
        if (isReservedWord(name) || name.matches("^\\d.*")) {
            name = escapeReservedWord(name);
        }
        return name;
    }

    @Override
    public String toParamName(String name) {
        if ("callback".equals(name)) {
            return "paramCallback";
        }
        return toVarName(name);
    }

    private static void setApexHttpRequestVendorExtensions(final CodegenOperation op) {
        // Map DELETE to DEL to avoid Apex reserved keyword conflict
        final String apexHttpMethod = "DELETE".equalsIgnoreCase(op.httpMethod)
                ? "DEL"
                : op.httpMethod.toUpperCase(Locale.ROOT);
        op.vendorExtensions.put("x-apex-http-request-method", apexHttpMethod);
        op.vendorExtensions.put("x-apex-http-request-endpoint", toApexHttpRequestEndpoint(op.path, "request."));
    }

    private static void setOperationMethodRequestDtoVendorExtensions(final CodegenOperation op) {
        // DTO inner class names: getPetById → [GetPetByIdRequest / GetPetByIdResponse]
        final String operationIdPascal = Character.toUpperCase(op.operationId.charAt(0))
                + op.operationId.substring(1);
        final String dtoClassName = operationIdPascal + "Request";
        final String responseClassName = operationIdPascal + "Response";
        op.vendorExtensions.put("x-apex-operation-req-class-name", dtoClassName);
        op.vendorExtensions.put("x-apex-operation-res-class-name", responseClassName);
        op.vendorExtensions.put("x-apex-operation-method-name", operationIdPascal);

        // Set vendor extensions for all parameters to generate setters in the request
        // DTO class.
        for (CodegenParameter param : op.allParams) {
            final String setter = "set" + Character.toUpperCase(param.paramName.charAt(0))
                    + param.paramName.substring(1);
            param.vendorExtensions.put("x-apex-operation-req-class-var-setter", setter);
            // The request DTO class name is needed to generate fluent setters returning the
            // correct type.
            param.vendorExtensions.put("x-apex-operation-req-class-name", dtoClassName);
            param.vendorExtensions.put("x-apex-operation-req-class-var-mock-value",
                    toApexOperationReqClassVarMockValue(param));
        }
    }

    private static String toApexHttpRequestEndpoint(final String path, final String prefix) {
        final String[] segments = path.split("/");

        final List<String> parts = new ArrayList<>();
        for (int i = 0; i < segments.length; i++) {
            final String part = segments[i];
            final boolean isParam = part.startsWith("{") && part.endsWith("}");
            final boolean isFirst = i == 0;
            final boolean isLast = i == segments.length - 1;
            if (isParam) {
                final String paramName = part.substring(1, part.length() - 1);
                if (isFirst) {
                    parts.add(prefix + paramName + " + '");
                } else if (isLast) {
                    parts.add("' + " + prefix + paramName);
                } else {
                    parts.add("' + " + prefix + paramName + " + '");
                }
            } else {
                if (isFirst) {
                    parts.add("'" + part);
                } else if (isLast) {
                    parts.add(part + "'");
                } else {
                    parts.add(part);
                }
            }
        }
        return String.join("/", parts);
    }
}
