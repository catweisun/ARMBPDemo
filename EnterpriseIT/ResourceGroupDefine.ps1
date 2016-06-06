Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameNetwork = "RG-ARM-BP-Network"
$RGNameVault = "RG-ARM-BP-Keyvault"
$loc = "China North"
#define resource group
New-AzureRmResourceGroup -Name $RGNameNetwork -Location $loc -Tag @(@{Name="Environment";Value="Dev"},@{Name="Type";Value="Network"})
New-AzureRmResourceGroup -Name $RGNameVault -Location $loc -Tag @(@{Name="Environment";Value="Dev"},@{Name="Type";Value="Security"})
#define secure store
New-AzureRmResourceGroupDeployment -Name "SecureStoreDeployment" -ResourceGroupName $RGNameVault -TemplateFile .\SecurityStore\azuredeploy.json -TemplateParameterFile .\SecurityStore\KeyVaultSetup.parameters.json -Mode Incremental
#define network
New-AzureRmResourceGroupDeployment -Name "NetworkDeployment" -ResourceGroupName $RGNameNetwork -TemplateFile .\Network\azuredeploy.json -Mode Incremental

