@isTest public class TestPermissionSetBuilder {
  private 
  String permissionSetName;
  private
  String permissionSetLabel;
    
  public
      TestPermissionSetBuilder setPermissionSetName(String permissionSetName){
          this.permissionSetName = permissionSetName;
          return this;
      }
  public
      TestPermissionSetBuilder setPermissionSetLabel(String permissionSetLabel){
          this.permissionSetLabel = permissionSetLabel;
          return this;
      }
  public
  PermissionSet build(){
      PermissionSet permSetObj = new PermissionSet(Name = permissionSetName,Label = permissionSetLabel);
      return permSetObj;
  }
   
 public PermissionSet buildAndSave()
 {
     PermissionSet permSetObj = build();
     insert permSetObj;
     return permSetObj;
 }
}