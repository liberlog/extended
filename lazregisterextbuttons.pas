{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregisterextbuttons; 

interface

uses
  u_regfsbuttons, u_regfbbuttons, u_regbfsbuttons, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('u_regfsbuttons', @u_regfsbuttons.Register); 
  RegisterUnit('u_regfbbuttons', @u_regfbbuttons.Register); 
  RegisterUnit('u_regbfsbuttons', @u_regbfsbuttons.Register); 
end; 

initialization
  RegisterPackage('lazregisterextbuttons', @Register); 
end.