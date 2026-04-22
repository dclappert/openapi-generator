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

    public static final String CLASS_PREFIX = "classPrefix";
    public static final String API_VERSION_DIRECTORY = "apiVersionDirectory";
    public static final String ACCESS_MODIFIER = "accessModifier";
    public static final String SALESFORCE_API_VERSION = "salesforceApiVersion";
    public static final String FLUENT_SETTERS = "fluentSetters";
    public static final String JSON_ACCESS = "jsonAccess";
    public static final String AURA_ENABLED = "auraEnabled";
    public static final String SUPPRESS_WARNINGS = "suppressWarnings";
    public static final String GENERATE_MODELS = "generateModels";
    public static final String GENERATE_APIS = "generateApis";
    public static final String GENERATE_CLIENT = "generateClient";

    protected String classPrefix = "Api";
    protected String apiVersionDirectory = "v1";
    protected String versionSuffix = "V1";
    protected String accessModifier = "global";
    protected String salesforceApiVersion = "62.0";
    protected boolean fluentSetters = true;
    protected boolean jsonAccess = true;
    protected boolean auraEnabled = false;
    protected String suppressWarnings = "";
    protected boolean generateModels = true;
    protected boolean generateApis = true;
    protected boolean generateClient = true;

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
        typeMapping.put("integer", "Integer");
        typeMapping.put("long", "Long");
        typeMapping.put("float", "Decimal");
        typeMapping.put("double", "Decimal");
        typeMapping.put("number", "Decimal");
        typeMapping.put("decimal", "Decimal");
        typeMapping.put("boolean", "Boolean");
        typeMapping.put("string", "String");
        typeMapping.put("UUID", "String");
        typeMapping.put("URI", "String");
        typeMapping.put("date", "Date");
        typeMapping.put("DateTime", "Datetime");
        typeMapping.put("date-time", "Datetime");
        typeMapping.put("object", "Map<String, Object>");
        typeMapping.put("map", "Map");
        typeMapping.put("array", "List");
        typeMapping.put("List", "List");
        typeMapping.put("set", "List");
        typeMapping.put("binary", "Blob");
        typeMapping.put("ByteArray", "Blob");
        typeMapping.put("file", "Blob");
        typeMapping.put("AnyType", "Object");
        typeMapping.put("any", "Object");

        instantiationTypes.put("array", "List");
        instantiationTypes.put("map", "Map");

        languageSpecificPrimitives.clear();
        languageSpecificPrimitives.add("Boolean");
        languageSpecificPrimitives.add("Integer");
        languageSpecificPrimitives.add("Long");
        languageSpecificPrimitives.add("Decimal");
        languageSpecificPrimitives.add("Double");
        languageSpecificPrimitives.add("String");
        languageSpecificPrimitives.add("Date");
        languageSpecificPrimitives.add("Datetime");
        languageSpecificPrimitives.add("Blob");
        languageSpecificPrimitives.add("Object");
        languageSpecificPrimitives.add("Id");

        setReservedWordsLowerCase(Arrays.asList(
                "abstract", "activate", "and", "any", "array", "as", "asc", "autonomous",
                "begin", "bigdecimal", "blob", "boolean", "break", "bulk", "by",
                "case", "cast", "catch", "char", "class", "collect", "commit", "const",
                "continue", "convertcurrency", "date", "datetime", "decimal", "default",
                "delete", "desc", "do", "else", "end", "enum", "exception", "exit",
                "export", "extends", "false", "final", "finally", "float", "for",
                "from", "future", "global", "goto", "group", "having", "hint",
                "if", "implements", "import", "inner", "insert", "instanceof", "int",
                "integer", "interface", "into", "join",
                "like", "limit", "list", "long", "loop",
                "map", "merge", "new",
                "not", "null", "nulls", "number", "object", "of", "on",
                "or", "outer", "override", "package", "parallel", "pragma", "private",
                "protected", "public", "retrieve", "return", "rollback", "runas",
                "savepoint", "search", "select", "set", "short", "sort", "stat",
                "static", "string", "super", "switch", "synchronized", "system",
                "testmethod", "then", "this", "throw", "time", "today", "tomorrow",
                "transaction", "trigger", "true", "try", "type", "undelete", "update",
                "upsert", "using", "virtual", "void", "webservice", "when", "where",
                "while", "yesterday"
        ));

        cliOptions.add(new CliOption(CLASS_PREFIX, "Prefix for all generated class names.").defaultValue("Api"));
        cliOptions.add(new CliOption(API_VERSION_DIRECTORY, "Version directory name (e.g. latest.v3).").defaultValue("v1"));
        cliOptions.add(new CliOption(ACCESS_MODIFIER, "Access modifier for generated classes and fields (global or public).").defaultValue("global"));
        cliOptions.add(new CliOption(SALESFORCE_API_VERSION, "Salesforce API version for cls-meta.xml.").defaultValue("62.0"));
        cliOptions.add(CliOption.newBoolean(FLUENT_SETTERS, "Generate fluent setters returning this (builder pattern).").defaultValue("true"));
        cliOptions.add(CliOption.newBoolean(JSON_ACCESS, "Add @JsonAccess(serializable='always' deserializable='always') to model classes.").defaultValue("true"));
        cliOptions.add(CliOption.newBoolean(AURA_ENABLED, "Add @AuraEnabled to each model field.").defaultValue("false"));
        cliOptions.add(new CliOption(SUPPRESS_WARNINGS, "PMD suppression string for @SuppressWarnings (empty = omit).").defaultValue(""));
        cliOptions.add(CliOption.newBoolean(GENERATE_MODELS, "Generate model classes.").defaultValue("true"));
        cliOptions.add(CliOption.newBoolean(GENERATE_APIS, "Generate API classes.").defaultValue("true"));
        cliOptions.add(CliOption.newBoolean(GENERATE_CLIENT, "Generate ApiClient and ApiHttpRequestBuilder supporting files.").defaultValue("true"));
    }

    @Override
    public void processOpts() {
        super.processOpts();

        if (additionalProperties.containsKey(CLASS_PREFIX)) {
            classPrefix = (String) additionalProperties.get(CLASS_PREFIX);
        }
        additionalProperties.put(CLASS_PREFIX, classPrefix);

        if (additionalProperties.containsKey(API_VERSION_DIRECTORY)) {
            apiVersionDirectory = (String) additionalProperties.get(API_VERSION_DIRECTORY);
        }
        versionSuffix = deriveVersionSuffix(apiVersionDirectory);
        additionalProperties.put(API_VERSION_DIRECTORY, apiVersionDirectory);
        additionalProperties.put("versionSuffix", versionSuffix);

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
        // Mustache treats empty string as truthy, so use a dedicated boolean flag
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

        String clientClassName = classPrefix + "ApiClient";
        String builderClassName = classPrefix + "ApiHttpRequestBuilder";
        String httpClientClassName = classPrefix + "HttpClient";
        String apiExceptionClassName = classPrefix + "ApiException";
        additionalProperties.put("clientClassName", clientClassName);
        additionalProperties.put("builderClassName", builderClassName);
        additionalProperties.put("httpClientClassName", httpClientClassName);
        additionalProperties.put("apiExceptionClassName", apiExceptionClassName);

        if (generateClient) {
            supportingFiles.add(new SupportingFile("apiClient.mustache", "common", clientClassName + ".cls"));
            supportingFiles.add(new SupportingFile("cls-meta.mustache", "common", clientClassName + ".cls-meta.xml"));
            supportingFiles.add(new SupportingFile("httpClient.mustache", "common", httpClientClassName + ".cls"));
            supportingFiles.add(new SupportingFile("cls-meta.mustache", "common", httpClientClassName + ".cls-meta.xml"));
            supportingFiles.add(new SupportingFile("apiException.mustache", "common", apiExceptionClassName + ".cls"));
            supportingFiles.add(new SupportingFile("cls-meta.mustache", "common", apiExceptionClassName + ".cls-meta.xml"));
            supportingFiles.add(new SupportingFile("httpRequestBuilder.mustache", "common", builderClassName + ".cls"));
            supportingFiles.add(new SupportingFile("cls-meta.mustache", "common", builderClassName + ".cls-meta.xml"));
        }
    }

    // Derives the class-name version suffix from the directory version string.
    // E.g. "latest.v3" → "V3", "v2" → "V2"
    private String deriveVersionSuffix(String versionDirectory) {
        if (StringUtils.isBlank(versionDirectory)) return "";
        String[] parts = versionDirectory.split("\\.");
        String last = parts[parts.length - 1];
        if (StringUtils.isBlank(last)) return "";
        return last.substring(0, 1).toUpperCase(Locale.ROOT) + last.substring(1);
    }

    @Override
    public String toModelName(String name) {
        String sanitized = sanitizeName(name);
        String camelized = camelize(sanitized);
        if (isReservedWord(camelized.toLowerCase(Locale.ROOT))) {
            camelized = "Model" + camelized;
        }
        if (camelized.matches("^\\d.*")) {
            camelized = "Model" + camelized;
        }
        return classPrefix + versionSuffix + camelized;
    }

    @Override
    public String toModelFilename(String name) {
        return toModelName(name);
    }

    @Override
    public String toApiName(String name) {
        if (StringUtils.isBlank(name)) {
            return classPrefix + versionSuffix + "DefaultApi";
        }
        String camelized = camelize(sanitizeName(name));
        return classPrefix + versionSuffix + camelized + "Api";
    }

    @Override
    public String toApiFilename(String name) {
        return toApiName(name);
    }

    @Override
    public String apiFileFolder() {
        return outputFolder + File.separator + "api" + File.separator + apiVersionDirectory;
    }

    @Override
    public String modelFileFolder() {
        return outputFolder + File.separator + "model" + File.separator + apiVersionDirectory;
    }

    @Override
    public String escapeReservedWord(String name) {
        if (this.reservedWordsMappings().containsKey(name)) {
            return this.reservedWordsMappings().get(name);
        }
        return "_" + name;
    }

    @Override
    public String getTypeDeclaration(Schema p) {
        if (ModelUtils.isArraySchema(p)) {
            Schema inner = ModelUtils.getSchemaItems(p);
            if (inner == null) return "List<Object>";
            return "List<" + getTypeDeclaration(inner) + ">";
        } else if (ModelUtils.isMapSchema(p)) {
            Schema inner = ModelUtils.getAdditionalProperties(p);
            if (inner == null) return "Map<String, Object>";
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
        return super.postProcessModels(objs);
    }

    @Override
    public OperationsMap postProcessOperationsWithModels(OperationsMap objs, List<ModelMap> allModels) {
        String clientClassName = classPrefix + "ApiClient";
        String builderClassName = classPrefix + "ApiHttpRequestBuilder";
        objs.put("clientClassName", clientClassName);
        objs.put("builderClassName", builderClassName);

        List<CodegenOperation> ops = objs.getOperations().getOperation();
        for (CodegenOperation op : ops) {
            // Map DELETE to DEL to avoid Apex reserved keyword conflict
            String apexHttpMethod = "DELETE".equalsIgnoreCase(op.httpMethod)
                    ? "DEL"
                    : op.httpMethod.toUpperCase(Locale.ROOT);
            op.vendorExtensions.put("x-apex-http-method", apexHttpMethod);

            // Convert OAS path template {param} to Apex string concatenation with request. prefix
            op.vendorExtensions.put("x-apex-path-request", toApexPathWithPrefix(op.path, "request."));

            // DTO inner class names: getPetById → GetPetByIdRequest / GetPetByIdResponse
            String operationIdPascal = Character.toUpperCase(op.operationId.charAt(0))
                    + op.operationId.substring(1);
            String dtoClassName = operationIdPascal + "Request";
            String responseClassName = operationIdPascal + "Response";
            op.vendorExtensions.put("x-apex-dto-class", dtoClassName);
            op.vendorExtensions.put("x-apex-response-class", responseClassName);

            // Duplicate dtoClassName and setter name onto each param — inside {{#allParams}},
            // Mustache resolves vendorExtensions against the param's map, shadowing the operation's.
            for (CodegenParameter param : op.allParams) {
                String setter = "set" + Character.toUpperCase(param.paramName.charAt(0))
                        + param.paramName.substring(1);
                param.vendorExtensions.put("x-apex-setter", setter);
                param.vendorExtensions.put("x-apex-dto-class", dtoClassName);
            }
        }

        return super.postProcessOperationsWithModels(objs, allModels);
    }

    // Converts an OAS path like /pet/{petId}/friends to 'pet/' + {prefix}petId + '/friends'
    private String toApexPathWithPrefix(String path, String prefix) {
        if (path == null) return "''";
        path = path.replaceFirst("^/", "");
        Matcher m = Pattern.compile("\\{([^}]+)\\}").matcher(path);
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            String paramName = toParamName(m.group(1));
            m.appendReplacement(sb, Matcher.quoteReplacement("' + " + prefix + paramName + " + '"));
        }
        m.appendTail(sb);
        path = "'" + sb + "'";
        // Clean up trailing + '' and leading '' +
        path = path.replaceAll(" \\+ ''$", "");
        path = path.replaceAll("^'' \\+ ", "");
        return path;
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
        if ("callback".equals(name)) return "paramCallback";
        return toVarName(name);
    }
}
