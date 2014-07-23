﻿{*********************************************************************}
{                                                                     }
{                                                                     }
{             TExtSearchEdit :                               }
{             Objet issu d'un TDBedit qui associe les         }
{             avantages de la DBEdit avec une recherche     }
{             Créateur : Matthieu Giroux                          }
{             31 Mars 2011                                            }
{                                                                     }
{                                                                     }
{*********************************************************************}

unit u_extsearchedit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}

interface

uses Classes,
     {$IFDEF FPC}
     LMessages, LCLType,
     {$ELSE}
     Messages, Windows,
     {$ENDIF}
     DB,DBCtrls,
     u_extformatedits,
     {$IFDEF VERSIONS}
     fonctions_version,
     {$ENDIF}
     fonctions_search_edit,
     DBGrids, StdCtrls;

type TSearchOptions = ( soMultiple );

const
{$IFDEF VERSIONS}
    gVer_TExtSearchDBEdit : T_Version = ( Component : 'Composants ISearchEdit' ;
                                          FileUnit : 'U_TExtSearchDBEdit' ;
                                          Owner : 'Matthieu Giroux' ;
                                          Comment : 'Searching in a dbedit.' ;
                                          BugsStory : '1.2.1.0 : Multiple Searchs.'
                                                    + '1.2.0.0 : TCustomSearchEdit creating.'
                                                    + '1.1.0.0 : ExtComboInsert inherit.'
                                                    + '1.0.1.5 : Testing popup and unfocusing.'
                                                    + '1.0.1.4 : MyLabel unset correctly.'
                                                    + '1.0.1.3 : Popup not erasing bug.'
                                                    + '1.0.1.2 : Testing on LAZARUS.'
                                                    + '1.0.1.1 : Delphi compatible.'
                                                    + '1.0.1.0 : Simple Edit capability on Lazarus Only.'
                                                    + '1.0.0.0 : Popup list.'
                                                    + '0.9.0.4 : Making comments.'
                                                    + '0.9.0.3 : Tested.'
                                                    + '0.9.0.2 : Not tested, upgrading.'
                                                    + '0.9.0.1 : Not tested, compiling on DELPHI.'
                                                    + '0.9.0.0 : In place not tested.';
                                          UnitType : 3 ;
                                          Major : 1 ; Minor : 2 ; Release : 1 ; Build : 0 );

{$ENDIF}
  SEARCHEDIT_GRID_DEFAULTS = [dgColumnResize, dgRowSelect, dgColLines, dgConfirmDelete, dgCancelOnExit, dgTabs, dgAlwaysShowSelection];
  SEARCHEDIT_GRID_DEFAULT_SCROLL = {$IFDEF FPC}ssAutoBoth{$ELSE}ssBoth{$ENDIF};
  SEARCHEDIT_SEARCH_OPTION_DEFAULT = soMultiple;
type

  { TCustomSearchDBEdit }

  TCustomSearchDBEdit = class(TExtFormatDBEdit,ISearchEdit)
  private
    // Lien de données
    FSearchSource: TFieldDataLink;
    FOnNotFound,
    FOnLocate ,
    FOnSet  : TNotifyEvent;
//    FSearchOptions : TSearchOptions;
    FOldColor ,
    FSearchFiltered,
    Flocated,
    FSet : Boolean;
    FListWidth : Word;
    FListLines : Integer;
    FTextSeparator : String;
    FFieldSeparator : Char;
    FSearchList : String;
    FListUp : Boolean;
    FNotifyOrder : TNotifyEvent;
    FPopup:TListPopupEdit;
    procedure p_setSearchDisplay ( AValue : String );
    function fs_getSearchDisplay : String ;
    procedure p_setSearchSource ( AValue : TDataSource );
    function fs_getSearchSource : TDataSource ;
    procedure WMSize(var Message: {$IFDEF FPC}TLMSize{$ELSE}TWMSize{$ENDIF}); message {$IFDEF FPC}LM_SIZE{$ELSE}WM_SIZE{$ENDIF};
    procedure WMSetFocus(var Message: {$IFDEF FPC}TLMSetFocus{$ELSE}TWMSetFocus{$ENDIF}); message {$IFDEF FPC}LM_SETFOCUS{$ELSE}WM_SETFOCUS{$ENDIF};
    procedure WMKillFocus(var Message: {$IFDEF FPC}TLMKillFocus{$ELSE}TWMKillFocus{$ENDIF}); message {$IFDEF FPC}LM_KILLFOCUS{$ELSE}WM_KILLFOCUS{$ENDIF};
    {$IFNDEF FPC}
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    {$ENDIF}
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function ListUp:Boolean;virtual;
    function ListLines:Integer;virtual;
    procedure Locating; virtual;
    procedure InitSearch; virtual;
    procedure NotFound; virtual;
    procedure SearchText; virtual;
    procedure FreePopup; virtual;
    procedure SetEvent ; virtual;
    procedure ValidateSearch; virtual;
    function GetFieldSearch: String; virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure TextChanged; {$IFDEF FPC}override;{$ELSE}virtual;{$ENDIF}
    {$IFDEF FPC}
    procedure UTF8KeyPress(var UTF8Key: TUTF8Char); override;
    {$ENDIF}
    procedure Change; override;
    property SearchLink : TFieldDataLink read FSearchSource write FSearchSource ;
  public
    procedure DoExit; override;
    {$IFDEF FPC}
    procedure PasteFromClipboard; override;
    procedure CutToClipboard; override;
    {$ENDIF}
    constructor Create ( Aowner : TComponent ); override;
    destructor Destroy ; override;
    property Located : Boolean read Flocated;
  published
//    property SearchOptions : String read fSearchOptions write fSearchOptions default SEARCHEDIT_SEARCH_OPTION_DEFAULT;
    property SearchDisplay : String read fs_getSearchDisplay write p_setSearchDisplay;
    property SearchList : String read FSearchList write FSearchList ;
    property DropDownRows : Integer read FListLines write FListLines default 5;
    property DropDownWidth : Word read FListWidth write FListWidth default 0;
    property DropUp : Boolean read FListUp write FListUp default False;
    property SearchFiltered : Boolean read FSearchFiltered write FSearchFiltered default False;
    property FieldSeparator : Char read FFieldSeparator write FFieldSeparator default ',';
    property TextSeparator : String read FTextSeparator write FTextSeparator;
    property SearchSource : TDatasource read fs_getSearchSource write p_setSearchSource ;
    property OnLocate : TNotifyEvent read FOnLocate write FOnLocate;
    property OnNotFound : TNotifyEvent read FOnNotFound write FOnNotFound;
    property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
    property OnSet : TNotifyEvent read FOnSet write FOnSet;
    property OnMouseEnter;
    property OnMouseLeave;
    property PopupMenu;
  end;

  { TCustomSearchDBEdit }

  { TCustomSearchEdit }

  TCustomSearchEdit = class(TExtFormatEdit,ISearchEdit)
  private
    // Lien de données
    FSearchSource: TFieldDataLink;
    FOnNotFound,
    FOnLocate ,
    FOnSet  : TNotifyEvent;
//    FSearchOptions : TSearchOptions;
    FOldColor ,
    FSearchFiltered,
    Flocated,
    FSet : Boolean;
    FListWidth : Word;
    FListLines : Integer;
    FTextSeparator : String;
    FFieldSeparator : Char;
    FSearchList : String;
    FListUp : Boolean;
    FNotifyOrder : TNotifyEvent;
    FPopup:TListPopupEdit;
    procedure p_setSearchDisplay ( AValue : String );
    function fs_getSearchDisplay : String ;
    procedure p_setSearchSource ( AValue : TDataSource );
    function fs_getSearchSource : TDataSource ;
    procedure WMSize(var Message: {$IFDEF FPC}TLMSize{$ELSE}TWMSize{$ENDIF}); message {$IFDEF FPC}LM_SIZE{$ELSE}WM_SIZE{$ENDIF};
    {$IFNDEF FPC}
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    {$ENDIF}
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function ListUp:Boolean;virtual;
    function ListLines:Integer;virtual;
    procedure InitSearch;virtual;
    procedure Locating; virtual;
    procedure NotFound; virtual;
    procedure SearchText; virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure FreePopup; virtual;
    procedure SetEvent ; virtual;
    procedure ValidateSearch; virtual;
    function GetFieldSearch: String; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure TextChanged; {$IFDEF FPC}override;{$ELSE}virtual;{$ENDIF}
    property SearchLink : TFieldDataLink read FSearchSource write FSearchSource ;
  public
    procedure DoExit; override;
    {$IFDEF FPC}
    procedure PasteFromClipboard; override;
    procedure CutToClipboard; override;
    {$ENDIF}
    constructor Create ( Aowner : TComponent ); override;
    destructor Destroy ; override;
    property Located : Boolean read Flocated;
  published
//    property SearchOptions : String read fSearchOptions write fSearchOptions default SEARCHEDIT_SEARCH_OPTION_DEFAULT;
    property SearchDisplay : String read fs_getSearchDisplay write p_setSearchDisplay ;
    property SearchList : String read FSearchList write FSearchList ;
    property SearchSource : TDatasource read fs_getSearchSource write p_setSearchSource ;
    property DropDownRows : Integer read FListLines write FListLines default 5;
    property DropDownWidth : Word read FListWidth write FListWidth default 0;
    property DropUp : Boolean read FListUp write FListUp default False;
    property SearchFiltered : Boolean read FSearchFiltered write FSearchFiltered default False;
    property FieldSeparator : Char read FFieldSeparator write FFieldSeparator default ',';
    property TextSeparator : String read FTextSeparator write FTextSeparator;
    property OnLocate : TNotifyEvent read FOnLocate write FOnLocate;
    property OnNotFound : TNotifyEvent read FOnNotFound write FOnNotFound;
    property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
    property OnSet : TNotifyEvent read FOnSet write FOnSet;
    property OnMouseEnter;
    property OnMouseLeave;
    property PopupMenu;
  end;


  { TExtSearchDBEdit }
  TExtSearchDBEdit = class(TCustomSearchDBEdit)
  end;

  { TExtSearchDBEdit }
  TExtSearchEdit = class(TCustomSearchEdit)
  end;

implementation

uses
     sysutils;

{ TExtSearchDBEdit }

// procedure TCustomSearchDBEdit.p_setSearchDisplay
// Setting The Search field on SearchSource
procedure TCustomSearchDBEdit.p_setSearchDisplay(AValue: String);
begin
  FSearchSource.FieldName:= AValue;
end;

// function TCustomSearchDBEdit.fs_getSearchDisplay
// Getting The Search field on SearchSource
function TCustomSearchDBEdit.fs_getSearchDisplay: String;
begin
  Result := FSearchSource.FieldName;
end;

// procedure TCustomSearchDBEdit.p_setSearchSource
// Setting the Search source
procedure TCustomSearchDBEdit.p_setSearchSource(AValue: TDataSource);
begin
  FSearchSource.DataSource := AValue;
end;

// function TCustomSearchDBEdit.fs_getSearchSource
// Getting the Search source
function TCustomSearchDBEdit.fs_getSearchSource: TDataSource;
begin
  Result := FSearchSource.DataSource;
end;

procedure TCustomSearchDBEdit.WMSize(var Message: {$IFDEF FPC}TLMSize{$ELSE}TWMSize{$ENDIF});
begin
  if ( Message.Width <> Width ) or ( Message.Height <> Height ) Then
    FreePopup;
  Inherited;
end;

procedure TCustomSearchDBEdit.WMSetFocus(var Message: {$IFDEF FPC}TLMSetFocus{$ELSE}TWMSetFocus{$ENDIF});
begin
  if Assigned(DataSource) Then
    Inherited;
end;

procedure TCustomSearchDBEdit.WMKillFocus(var Message: {$IFDEF FPC}TLMKillFocus{$ELSE}TWMKillFocus{$ENDIF});
begin
  if Assigned(DataSource) Then
    Inherited;
end;

procedure TCustomSearchDBEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if  ( Operation  = opRemove )
  and ( AComponent = Datasource   )
   Then Datasource := nil;
end;

function TCustomSearchDBEdit.ListUp: Boolean;
begin
  Result := FListUp;
end;

function TCustomSearchDBEdit.ListLines: Integer;
begin
  Result := FListLines;
end;

procedure TCustomSearchDBEdit.FreePopup;
begin
  FreeAndNil(FPopup);
end;

// procedure TCustomSearchDBEdit.Located
// Record Found function
procedure TCustomSearchDBEdit.Locating;
var li_pos : Integer;
    ls_temp : String;
begin
  Flocated  := True;
  if fb_SearchLocating( FPopup,Self,FSearchSource, FTextSeparator ,FSearchList,FFieldSeparator,FListWidth)
   Then ValidateSearch
   Else
    if assigned ( FOnLocate ) Then
      FOnLocate ( Self );
end;

procedure TCustomSearchDBEdit.InitSearch;
begin
  Flocated  := False;
  FSet  := False;
end;

// procedure TCustomSearchDBEdit.NotFound
// NotFound function
procedure TCustomSearchDBEdit.NotFound;
begin
  Flocated  := False;
   // not found : no popup
  if Assigned(FPopup) Then
    FPopup.Visible:=False;
  if assigned ( FOnNotFound ) Then
    FOnNotFound ( Self );
end;

procedure TCustomSearchDBEdit.SearchText;
begin
  FSet := False;
  if fb_SearchText ( Self, FSearchSource, FSearchFiltered, FTextSeparator )
   Then Locating
   Else NotFound; // not found : no popup
end;

// procedure TCustomSearchDBEdit.KeyUp
//  searching on key up
procedure TCustomSearchDBEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if not Assigned ( FSearchSource.DataSet )
  or ( FSearchSource.FieldName = '' ) then
   Exit;
  if fb_KeyUp ( Self, Key, Flocated, FSet, FPopup )
  and not ( Key in [ VK_TAB, VK_BACK ])
  and ( Text > '' )
   Then SearchText;


end;

// procedure TCustomSearchDBEdit.ValidateSearch
// Calling OnSet Event if setted
procedure TCustomSearchDBEdit.ValidateSearch;
Begin
  if not FSet
  and Flocated
   Then
     with FSearchSource.DataSet do
      Begin
        Flocated  := True;
        FSet := True;
        Text := FindField ( FSearchSource.FieldName  ).AsString;
        if assigned ( FOnSet ) Then
          FOnSet ( Self )
      End ;
end;

function TCustomSearchDBEdit.EditCanModify: Boolean;
begin
  Result:= not Assigned(DataSource) or inherited EditCanModify;
end;
// return field for datafield
function TCustomSearchDBEdit.GetFieldSearch: String;
begin
  Result:=fs_getSearchDisplay;
end;

procedure TCustomSearchDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
var OldKey : Integer;
begin
  OldKey:=Key;
  inherited KeyDown(Key, Shift);
  if not assigned ( DataSource ) and ( OldKey in [VK_ESCAPE,VK_DELETE, VK_BACK])
   Then Key:=OldKey;
end;

{$IFDEF FPC}
procedure TCustomSearchDBEdit.UTF8KeyPress(var UTF8Key: TUTF8Char);
begin
  // When no datasource so can edit
  if assigned ( DataSource )
   Then inherited UTF8KeyPress(UTF8Key)
   else
     if Assigned(OnUTF8KeyPress)
      Then OnUTF8KeyPress ( Self, UTF8Key );
end;
{$ENDIF}

procedure TCustomSearchDBEdit.Change;
begin
  if Assigned(DataSource)
   Then
    inherited Change
   Else
     if Assigned(OnChange) Then
      OnChange ( Self );
  {$IFNDEF FPC}
  TextChanged;
  {$ENDIF}
end;


// procedure TCustomSearchDBEdit.DoExit
// Setting the label and ExtSearchDBEdit color
procedure TCustomSearchDBEdit.DoExit;
begin
  ValidateSearch;
  inherited DoExit;
  if assigned ( FPopup )
  and not FPopup.Focused Then
    FreePopup;
end;

procedure TCustomSearchDBEdit.TextChanged;
begin
  {$IFDEF FPC}
  inherited TextChanged;
  {$ENDIF}
  if Text = '' Then
   InitSearch;
end;


{$IFDEF FPC}
procedure TCustomSearchDBEdit.PasteFromClipboard;
{$ELSE}
procedure TCustomSearchDBEdit.WMPaste(var Message: TMessage);
{$ENDIF}
begin
  InitSearch;
  inherited;
end;

{$IFDEF FPC}
procedure TCustomSearchDBEdit.CutToClipboard;
{$ELSE}
procedure TCustomSearchDBEdit.WMCut(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  InitSearch;
end;

// procedure TCustomSearchDBEdit.SetEvent
// calling FNotifyOrder Event
procedure TCustomSearchDBEdit.SetEvent;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TCustomSearchDBEdit.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  //DataLink.OnDataChange := DataChange;
  FSearchFiltered := False;
  FListUp := False;
  FListWidth:=0;
  FFieldSeparator := ',';
  FListLines := 5;
  FPopup := nil;
  FSearchSource := TFieldDataLink.Create;
  InitSearch;
//  fSearchOptions := SEARCHEDIT_SEARCH_OPTION_DEFAULT;
  FTextSeparator := '';
end;

// destructor TCustomSearchDBEdit.Destroy
// Destroying
destructor TCustomSearchDBEdit.Destroy;
begin
  inherited Destroy;
  FSearchSource.Destroy;
end;


{ TCustomSearchDBEdit }

// procedure TCustomSearchDBEdit.p_setSearchDisplay
// Setting The Search field on SearchSource
procedure TCustomSearchEdit.p_setSearchDisplay(AValue: String);
begin
  FSearchSource.FieldName:= AValue;
end;

// function TCustomSearchEdit.fs_getSearchDisplay
// Getting The Search field on SearchSource
function TCustomSearchEdit.fs_getSearchDisplay: String;
begin
  Result := FSearchSource.FieldName;
end;

procedure TCustomSearchEdit.p_setSearchSource(AValue: TDataSource);
begin
  FSearchSource.Datasource := AValue;
end;

function TCustomSearchEdit.fs_getSearchSource: TDataSource;
begin
  Result := FSearchSource.Datasource;
end;

procedure TCustomSearchEdit.WMSize(var Message: {$IFDEF FPC}TLMSize{$ELSE}TWMSize{$ENDIF});
begin
  if ( Message.Width <> Width ) or ( Message.Height <> Height ) Then
    FreePopup;
  Inherited;
end;

procedure TCustomSearchEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if  not ( csDestroying in ComponentState )
  and ( Operation  = opRemove )
  and ( AComponent = Searchsource   )
   Then Searchsource := nil;
end;

function TCustomSearchEdit.ListUp: Boolean;
begin
  Result := FListUp;
end;

function TCustomSearchEdit.ListLines: Integer;
begin
  Result := FListLines;
end;

procedure TCustomSearchEdit.FreePopup;
begin
  FreeAndNil(FPopup);
end;

// procedure TCustomSearchEdit.Located
// Record Found function
procedure TCustomSearchEdit.Locating;
var li_pos : Integer;
    ls_temp : String;
begin
  Flocated  := True;
  if fb_SearchLocating( FPopup,Self,FSearchSource, FTextSeparator ,FSearchList,FFieldSeparator,FListWidth)
   Then ValidateSearch
   Else
    if assigned ( FOnLocate ) Then
      FOnLocate ( Self );
end;

procedure TCustomSearchEdit.InitSearch;
begin
  Flocated  := False;
  FSet  := False;
end;

// procedure TCustomSearchEdit.NotFound
// NotFound function
procedure TCustomSearchEdit.NotFound;
begin
  Flocated  := False;
   // not found : no popup
  if Assigned(FPopup) Then
    FPopup.Visible:=False;
  if assigned ( FOnNotFound ) Then
    FOnNotFound ( Self );
end;

procedure TCustomSearchEdit.SearchText;
begin
  FSet := False;
  if fb_SearchText ( Self, FSearchSource, FSearchFiltered, FTextSeparator )
   Then Locating
   Else NotFound; // not found : no popup
end;

// procedure TCustomSearchEdit.KeyUp
//  searching on key up
procedure TCustomSearchEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if not Assigned ( FSearchSource.DataSet )
  or ( FSearchSource.FieldName = '' ) then
   Exit;
  if fb_KeyUp ( Self, Key, Flocated, FSet, FPopup )
  and not ( Key in [ VK_TAB, VK_BACK ])
  and ( Text > '' )
   Then SearchText;


end;

// procedure TCustomSearchEdit.ValidateSearch
// Calling OnSet Event if setted
procedure TCustomSearchEdit.ValidateSearch;
Begin
  if not FSet
  and Flocated
   Then
     with FSearchSource.DataSet do
      Begin
        Flocated  := True;
        FSet := True;
        Text := FindField ( FSearchSource.FieldName  ).AsString;
        if assigned ( FOnSet ) Then
          FOnSet ( Self )
      End ;
end;

// return field for datafield
function TCustomSearchEdit.GetFieldSearch: String;
begin
  Result:=fs_getSearchDisplay;
end;

procedure TCustomSearchEdit.KeyDown(var Key: Word; Shift: TShiftState);
var OldKey : Integer;
begin
  OldKey:=Key;
  inherited KeyDown(Key, Shift);
  if OldKey in [VK_ESCAPE,VK_DELETE, VK_BACK]
   Then Key:=OldKey;
end;


// procedure TCustomSearchEdit.DoExit
// Setting the label and ExtSearchDBEdit color
procedure TCustomSearchEdit.DoExit;
begin
  ValidateSearch;
  inherited DoExit;
  if assigned ( FPopup )
  and not FPopup.Focused Then
    FreePopup;
end;

procedure TCustomSearchEdit.TextChanged;
begin
  {$IFDEF FPC}
  inherited TextChanged;
  {$ENDIF}
  if Text = '' Then
   InitSearch;
end;


{$IFDEF FPC}
procedure TCustomSearchEdit.PasteFromClipboard;
{$ELSE}
procedure TCustomSearchEdit.WMPaste(var Message: TMessage);
{$ENDIF}
begin
  InitSearch;
  inherited;
end;

{$IFDEF FPC}
procedure TCustomSearchEdit.CutToClipboard;
{$ELSE}
procedure TCustomSearchEdit.WMCut(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  InitSearch;
end;

// procedure TCustomSearchEdit.SetEvent
// calling FNotifyOrder Event
procedure TCustomSearchEdit.SetEvent;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TCustomSearchEdit.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  //DataLink.OnDataChange := DataChange;
  FSearchFiltered := False;
  FListUp := False;
  FListWidth:=0;
  FFieldSeparator := ',';
  FListLines := 5;
  FPopup := nil;
  FSearchSource := TFieldDataLink.Create;
  InitSearch;
//  fSearchOptions := SEARCHEDIT_SEARCH_OPTION_DEFAULT;
  FTextSeparator := '';
end;

// destructor TCustomSearchEdit.Destroy
// Destroying
destructor TCustomSearchEdit.Destroy;
begin
  inherited Destroy;
  FSearchSource.Destroy;
end;

{$IFDEF VERSIONS}
initialization
  // Versioning
  p_ConcatVersion ( gVer_TExtSearchDBEdit );
{$ENDIF}
end.
