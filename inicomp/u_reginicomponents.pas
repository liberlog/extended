unit u_reginicomponents;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}


{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

interface

uses
  Classes,
{$IFDEF FPC}
  lresources,
{$ENDIF}
  SysUtils;

procedure Register;

implementation

uses  {$IFDEF FPC}
  unite_messages,
  {$ELSE}
  unite_messages_delphi,
  {$ENDIF}
{$IFDEF FPC}
     ComponentEditors, dbpropedits, PropEdits,
{$ELSE}
     DBReg, Designintf,
{$ENDIF}
  {$IFDEF MENUBAR}u_extmenutoolbar, u_extmenucustomize, {$ENDIF}
   U_OnFormInfoIni;

procedure Register;
begin
  RegisterComponents(CST_PALETTE_COMPOSANTS_INVISIBLE, [TOnFormInfoIni]);
  {$IFDEF MENUBAR}
  RegisterComponents(CST_PALETTE_COMPOSANTS_INVISIBLE, [ TExtMenuCustomize ]);
  RegisterComponents(CST_PALETTE_COMPOSANTS, [ TExtMenuToolBar ]);
  {$ENDIF}
end;

{$IFDEF FPC}
initialization
  {$i U_OnFormInfoIni.lrs}
  {$IFDEF MENUBAR}
  {$I u_extmenucustomize.lrs}
  {$ENDIF}
{$ENDIF}
end.
