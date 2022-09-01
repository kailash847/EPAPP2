#
# This tests whether the ARM template for Data Migration Tool will be properly deployed or not.
#

Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] [Parameter(Mandatory=$true)] $RootDirectory
)

Describe "Data Migration Tool Deployment Tests" {
    # Init
    BeforeAll {
    }

    # Teardown
    AfterAll {
    }

    # Tests whether the cmdlet returns value or not.
    Context "When Data Migration Tool deployed with parameters" {
        $workload = 'test'
        $output = az deployment group validate `
            -g $ResourceGroupName `
            --template-file $RootDirectory\DataMigrationTool\azuredeploy.json `
            --parameters `@$RootDirectory\DataMigrationTool\azuredeploy.parameters.json `
            --parameters workload=$workload `
            | ConvertFrom-Json
        
        $result = $output.properties

        It "Should be deployed successfully" {
            $result.provisioningState | Should -Be "Succeeded"
        }
    }
}
