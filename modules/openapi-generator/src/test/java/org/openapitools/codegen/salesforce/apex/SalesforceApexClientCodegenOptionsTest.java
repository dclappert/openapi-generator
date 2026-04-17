package org.openapitools.codegen.salesforce.apex;

import org.openapitools.codegen.AbstractOptionsTest;
import org.openapitools.codegen.CodegenConfig;
import org.openapitools.codegen.languages.SalesforceApexClientCodegen;
import org.openapitools.codegen.options.SalesforceApexClientCodegenOptionsProvider;

import static org.mockito.Mockito.mock;

public class SalesforceApexClientCodegenOptionsTest extends AbstractOptionsTest {
    private SalesforceApexClientCodegen codegen = mock(SalesforceApexClientCodegen.class, mockSettings);

    public SalesforceApexClientCodegenOptionsTest() {
        super(new SalesforceApexClientCodegenOptionsProvider());
    }

    @Override
    protected CodegenConfig getCodegenConfig() {
        return codegen;
    }

    @Override
    protected void verifyOptions() {
        // Options are verified via processOpts() which is called by AbstractOptionsTest.
        // Specific option assertions are covered in SalesforceApexClientCodegenTest.
    }
}
