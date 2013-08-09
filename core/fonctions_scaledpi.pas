﻿unit fonctions_scaledpi;

interface

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

uses
  Forms, Graphics,
  {$IFDEF VERSIONS}
    fonctions_version,
  {$ENDIF}
  Controls, Classes, sysutils;

Const
  FromDPI=8;//Screen.MenuFont.Size de la conception
  SCALE_NODE_HEIGHT = 'DefaultNodeHeight';
  SCALE_GLYPH_SIZE  = 'GlyphSize';
  {$IFDEF VERSIONS}
  gver_fonctions_scaledpi : T_Version = ( Component : 'Fonctions d''adaptation de fontes' ;
                                     FileUnit : 'fonctions_scaledpi' ;
              			                 Owner : 'Matthieu Giroux' ;
              			                 Comment : 'Adapt forms and controls to system.' ;
              			                 BugsStory :  'Version 1.0.0.0 : OK on linux with ini.' + #13#10 +
                                                              'Version 0.9.9.0 : OK on windows.' + #13#10 +
                                                              'Version 0.9.0.0 : To test.';
              			                 UnitType : 1 ;
              			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );

{$ENDIF}

procedure p_addtoSoftware;
procedure HighDPI;
procedure ScaleDPIControl(const Control: TControl;const ANewEchelle:Extended);
function Scale(const Valeur:Integer;const ANewEchelle:Extended):Integer;
procedure ScaleFormShow(const Control: TCustomForm;const ANewEchelle:Extended);
procedure ScaleFormCreate(const Control: TCustomForm;const ANewEchelle:Extended);
function fb_CalculateScale ( var AEchelle : Extended ):Boolean;


type

  { TDMAdaptForms }

  TDMAdaptForms = class(TDataModule)
    procedure ApplicationActivate ( Sender : TObject );
  private
    { private declarations }
  published
    { published declarations }
    constructor Create ( AOwner : TComponent ); override;

  end;

var
  gb_AdaptFormsToOS : Boolean = True;
  ge_FontsScale:Extended=1;

implementation

uses fonctions_proprietes, math, typinfo, Grids;

var ge_OldApplicationActivate : TNotifyEvent = nil;
    DMAdaptForms: TDMAdaptForms = nil;

// Optional Application.OnActivate Event ( not using FormAdapt )
procedure TDMAdaptForms.ApplicationActivate ( Sender : TObject );
Begin
  if Assigned(ge_OldApplicationActivate) Then
    ge_OldApplicationActivate ( Sender );
  HighDPI;
end;

// no lfm ( not using FormAdapt )
constructor TDMAdaptForms.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  if (ClassType <> TDataModule) and
     not (csDesigning in ComponentState) then
    begin
    if OldCreateOrder then
      DoCreate;
    end;
end;

// calculate scale from system ( windows only )
function fb_CalculateScale ( var AEchelle : Extended ):Boolean;
var
  LNewEchelle : Extended;
Begin
  if not gb_AdaptFormsToOS Then
  Begin
    Result := False;
    Exit;
  end;
  if Screen.MenuFont.Size = 0
    Then LNewEchelle:=FromDPI
    Else LNewEchelle:=Screen.MenuFont.Size;
  {WriteLn(IntToStr(Screen.SystemFont.Size));
  WriteLn(IntToStr(Screen.HintFont.Size));
  WriteLn(IntToStr(Screen.IconFont.Size));
  WriteLn(IntToStr(Screen.MenuFont.Size));}

  LNewEchelle:=LNewEchelle/FromDPI*AEchelle;
  Result := LNewEchelle<>AEchelle;
  AEchelle:=LNewEchelle;
End;

// Scale all Applications forms
procedure HighDPI;
var
  i: integer;
begin
  if fb_CalculateScale ( ge_FontsScale ) then
    for i:=0 to Screen.FormCount-1 do
      ScaleFormShow(Screen.Forms[i],ge_FontsScale);
end;

// Scale a value
function Scale(const Valeur:Integer;const ANewEchelle:Extended):Integer;
Var
  Ext:Extended;
begin
  Ext:=Valeur*ANewEchelle;
  if Ext>=0 then
    Result:=Trunc(Ext+0.5)
  else
    Result:=Trunc(Ext-0.5);
end;

// scale on Form Show
procedure ScaleFormShow(const Control: TCustomForm;const ANewEchelle:Extended);
var
  i: integer;
Begin
  with Control do
   Begin
     {$IFDEF FPC}BeginUpdateBounds;{$ENDIF}

     Font.Size:=Scale(Font.Size,ANewEchelle);
     for i:=0 to Control.ControlCount-1 do
      ScaleDPIControl(Control.Controls[i],ANewEchelle);
     {$IFDEF FPC}EndUpdateBounds;{$ENDIF}

   End;
end;
// scale on form create
procedure ScaleFormCreate(const Control: TCustomForm;const ANewEchelle:Extended);
var
  ANew: integer;
Begin
  with Control do
   Begin
//     AutoSize:=True;
     ANew   := Min ( Screen.{$IFDEF WINDOWS}WorkAreaWidth{$ELSE}Width{$ENDIF}, Scale(Width,ANewEchelle));
     Left   := Max ( 0, Left + Width - ANew );
     Width  := ANew;
     ANew   := Min ( Screen.{$IFDEF WINDOWS}WorkAreaHeight{$ELSE}Height{$ENDIF}, Scale(Height,ANewEchelle));
     Top    := Max ( 0, Top + Height - ANew );
     Height := ANew;

   End;
end;

// scale a font
procedure ScaleFont(const Control: TObject;const ANewEchelle:Extended);
var  AFont : TFont;
Begin
  if ( Control is TCustomForm )
  or not fb_getComponentBoolProperty(Control,'ParentFont', False ) Then
   Begin
    AFont := TFont ( fobj_getComponentObjectProperty ( Control, 'Font' ));
    if assigned ( AFont ) then
     Begin
      AFont.Size:=Scale(AFont.Size,ANewEchelle);
     end;
   end;
end;

// scale a control
procedure ScaleDPIControl(const Control: TControl;const ANewEchelle:Extended);
var
  i: integer;
  WinControl: TWinControl;
  AColumn : TCollection;
begin
  with Control do
  begin
    with Constraints do
    begin
      MaxHeight:=Scale(MaxHeight,ANewEchelle);
      MaxWidth:=Scale(MaxWidth,ANewEchelle);
      MinHeight:=Scale(MinHeight,ANewEchelle);
      MinWidth:=Scale(MinWidth,ANewEchelle);
    end;

    if not ( Control is TCustomForm )
    and    ( Align   <> alClient    ) then
      begin
        if not (Align in [alTop,alBottom]) then
        begin
          if not (akRight in Anchors) and (Align<>alRight) then
            Left:=Scale(Left,ANewEchelle);
          if ([akRight,akLeft]*Anchors<>[akRight,akLeft]) then
            Width:=Scale(Width,ANewEchelle);
        end;
        if not (Align in [alLeft,alRight])then
        begin
          if (not (akBottom in Anchors))and(Align<>alBottom) then
            Top:=Scale(Top,ANewEchelle);
          if [akBottom,akTop]*Anchors<>[akBottom,akTop] then
            Height:=Scale(Height,ANewEchelle);
        end;
      end;

    if assigned ( GetPropInfo ( Control, SCALE_NODE_HEIGHT )) Then
     Begin
      SetPropValue(Control, SCALE_NODE_HEIGHT, Scale ( GetPropValue (Control, SCALE_NODE_HEIGHT ), ANewEchelle));
     end;
    if assigned ( GetPropInfo ( Control, SCALE_GLYPH_SIZE )) Then
     Begin
      SetPropValue(Control, SCALE_GLYPH_SIZE, Scale ( GetPropValue (Control, SCALE_GLYPH_SIZE ), ANewEchelle));
     end;
    if ( Control is TCustomGrid )
    and assigned ( GetPropInfo ( Control, CST_PROPERTY_COLUMNS )) Then
     Begin
       AColumn := GetObjectProp ( Control, CST_PROPERTY_COLUMNS ) as TCollection;
       with AColumn do
       for i := 0 to Count - 1 do
        Begin
          ScaleFont( Items [ i ],ANewEchelle);
          if assigned ( GetPropInfo ( Items [ i ], CST_PROPERTY_WIDTH )) Then
            SetPropValue ( Items [ i ], CST_PROPERTY_WIDTH,
                           Scale ( GetPropValue ( Items [ i ], CST_PROPERTY_WIDTH )
                                  , ANewEchelle ));
        end;
     end;
    ScaleFont(Control,ANewEchelle);
  end;

  if Control is TWinControl then
  begin
    WinControl:=TWinControl(Control);
    for i:=0 to WinControl.ControlCount-1 do
      ScaleDPIControl(WinControl.Controls[i],ANewEchelle);
  end;
end;

// main optinal procedure ( not using FormAdapt )
procedure p_addtoSoftware;
Begin
  ge_OldApplicationActivate := Application.OnActivate;
  if DMAdaptForms = nil Then
    DMAdaptForms := TDMAdaptForms.Create(Application);
  Application.OnActivate    := TNotifyEvent ( fmet_getComponentMethodProperty ( DMAdaptForms, 'ApplicationActivate' ) );
end;

initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gver_fonctions_scaledpi );
{$ENDIF}
end.