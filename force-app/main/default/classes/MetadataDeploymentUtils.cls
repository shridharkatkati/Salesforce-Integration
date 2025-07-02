public class MetadataDeploymentUtils Implements Metadata.DeployCallback{
    public void handleResult(Metadata.DeployResult result,
                             Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug('Deployment was successful');
        } else {
            System.debug('Deployment was not successful');
        }
    }

    public void createUpdateAndDeployMetadata(String metaObjName, String metaRecordName, String label, Map<String,Object> fieldVsValuesMap) {
    // Setup custom metadata to be created in the subscriber org.
    Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
    customMetadata.fullName = metaObjName+'.'+metaRecordName; // 'ISVNamespace__MetadataTypeName.MetadataRecordName';
    customMetadata.label = label;

    for(String field: fieldVsValuesMap.keySet()){
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = field;
        customField.value = fieldVsValuesMap.get(field);

        customMetadata.values.add(customField);
    }

    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
    mdContainer.addMetadata(customMetadata);

    

    // Enqueue custom metadata deployment
    Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, new MetadataDeploymentUtils());
  }
}