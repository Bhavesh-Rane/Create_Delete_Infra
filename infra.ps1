param(
    [string]$action
)

$resourceGroupName = "MyResourceGroup"
$location = "eastus"
$vnetName = "MyVNet"
$subnetName = "MySubnet"
$nsgName = "MyNSG"
$nsgRuleName = "MyNSGRule"
$sourceIpAddress = "10.0.0.1/32" 
$vmName = "MyVM" 

if ($action -eq "launch") {
        az group create 
        --name $resourceGroupName 
        --location $location
    
        az network vnet create 
        --name $vnetName 
        --resource-group $resourceGroupName 
        --location $location 
        --address-prefixes "10.0.0.0/16" 
        --subnet-name $subnetName 
        --subnet-prefixes "10.0.1.0/24"
    
        az network nsg create 
        --name $nsgName
        --resource-group $resourceGroupName
        --location $location
    az network nsg rule create
        --name $nsgRuleName 
        --resource-group $resourceGroupName
        --nsg-name $nsgName
        --priority 100 
        --source-address-prefixes $sourceIpAddress
        --destination-port-ranges "22"
        --access Allow `
        --protocol Tcp
    
    az vm create 
        --name $vmName 
        --resource-group $resourceGroupName 
        --image UbuntuLTS 
        --admin-username azureuser 
        --generate-ssh-keys 
        --vnet-name $vnetName
        --subnet $subnetName 
        --nsg $nsgName
}

elseif ($action -eq "destroy") {
    az group delete 
        --name $resourceGroupName 
        --yes
}

else {
    Write-Error "Please select 'launch' or 'destroy'"
}
