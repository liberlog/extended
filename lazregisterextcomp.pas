{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregisterextcomp;

interface

uses
  u_reginicomponents, u_regextcomponents, u_regextfilecopy, 
  u_regextracomponents, u_regimagecomponents, u_regfwbuttons, 
  u_regfwbuttons_appli, u_regsbbuttons, u_registerforms, U_RegisterGroupView, 
  u_regreports_components, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('u_reginicomponents', @u_reginicomponents.Register);
  RegisterUnit('u_regextcomponents', @u_regextcomponents.Register);
  RegisterUnit('u_regextfilecopy', @u_regextfilecopy.Register);
  RegisterUnit('u_regextracomponents', @u_regextracomponents.Register);
  RegisterUnit('u_regimagecomponents', @u_regimagecomponents.Register);
  RegisterUnit('u_regfwbuttons', @u_regfwbuttons.Register);
  RegisterUnit('u_regfwbuttons_appli', @u_regfwbuttons_appli.Register);
  RegisterUnit('u_regsbbuttons', @u_regsbbuttons.Register);
  RegisterUnit('u_registerforms', @u_registerforms.Register);
  RegisterUnit('U_RegisterGroupView', @U_RegisterGroupView.Register);
  RegisterUnit('u_regreports_components', @u_regreports_components.Register);
end;

initialization
  RegisterPackage('lazregisterextcomp', @Register);
end.
