﻿unit u_buttons_appli;

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}
{$IFDEF FPC}
{$mode Delphi}
{$ELSE}
{$R *.DCR}
{$ENDIF}

interface

uses
{$IFDEF FPC}
   lresources,
{$ELSE}
   Windows,
{$ENDIF}
  Classes,
{$IFDEF VERSIONS}
   fonctions_version,
{$ENDIF}
  Controls,
  JvXPButtons, Graphics;

const
{$IFDEF VERSIONS}
    gVer_buttons_appli : T_Version = ( Component : 'Boutons personnalisés' ;
                                       FileUnit : 'u_buttons_appli' ;
                                       Owner : 'Matthieu Giroux' ;
                                       Comment : 'Composants boutons personnalisés.' ;
                                       BugsStory : '1.0.0.0 : Version OK.'+ #13#10
                                                 + '0.8.0.1 : Group view buttons better.'+ #13#10
                                                 + '0.8.0.0 : Gestion à tester.';
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}
   CST_FWCLOSE='TFWCLOSE';
   CST_FWCANCEL='TFWCANCEL';
   CST_FWBASKET='TFWBASKET';
   CST_FWOK='TFWOK';
   CST_FWINSERT='TFWINSERT';
   CST_FWDELETE='TFWDELETE';
   CST_FWIMPORT='TFWIMPORT';
   CST_FWEXPORT='TFWEXPORT';
   CST_FWTRASH='TFWTRASH';
   CST_FWCOPY='TFWCOPY';
   CST_FWQUIT='TFWQUIT';
   CST_FWERASE='TFWERASE';
   CST_FWSAVEAS='TFWSAVEAS';
   CST_FWPRINT='TFWPRINT';
   CST_FWDOCUMENT='TFWDOCUMENT';
   CST_FWPREVIEW='TFWPREVIEW';
   CST_FWNEXT='TFWNEXT';
   CST_FWPRIOR='TFWPRIOR';
   CST_FWINIT='TFWINIT';
   CST_FWCONFIG='TFWCONFIG';
   CST_FWWIDTH_CLOSE_BUTTON = 80 ;
   CST_FWLOAD='TFWLOAD';
{$IFDEF GROUPVIEW}
   CST_FWOUTSELECT='TFWOUTSELECT';
   CST_FWINSELECT='TFWINSELECT';
   CST_FWOUTALL='TFWOUTALL';
   CST_FWINALL='TFWINALL';
   CST_WIDTH_BUTTONS_MOVING  = 60;
   CST_HEIGHT_BUTTONS_MOVING = 40;
   CST_WIDTH_BUTTONS_ACTIONS  = 120;
   CST_HEIGHT_BUTTONS_ACTIONS = 20;
{$ENDIF}

procedure p_Load_Buttons_Appli ( const FGLyph : {$IFDEF USEJVCL}TJvPicture{$ELSE}TPicture{$ENDIF USEJVCL}; const as_Resource : String ; const acon_control :TControl);

type

   IFWButton = interface
   ['{620AE27F-98C1-8A6D-E54F-FE57A16207E5}']
       procedure Paint;
   end;
{ TFWClose }
    TFWXPButton = class ( TJvXPButton, IFWButton )
      published
       property Glyph stored False;
     End;

   TFWClose = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
       procedure Click; override;
      published

       property Width default CST_FWWIDTH_CLOSE_BUTTON ;
     End;

{ TFWOK }
   TFWOK = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
      published
       
     End;

{ TFWInsert }
   TFWInsert = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
      published
       
     End;
{ TFWAdd }
   TFWAdd = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
      published
       
     End;

{ TFWDelete }
  TFWDelete = class ( TFWXPButton )
     private
     public
      constructor Create ( AOwner : TComponent ) ; override;
      procedure Loaded; override;
     published
      
    End;

{ TFWDocument }
   TFWDocument = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;
      published
       
     End;

{ TFWQuit }
   TFWQuit = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
      published
       
     End;

{ TFWErase }
   TFWErase = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
      published
       
     End;

{ TFWSaveAs }
   TFWSaveAs = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;

      published
       
     End;

   { TFWLoad }
      TFWLoad = class ( TFWXPButton )
         private
         public
          constructor Create ( AOwner : TComponent ) ; override;
          procedure Loaded; override;

         published
          
        End;

{ TFWPrint }
   TFWPrint = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;

      published
       
     End;

{ TFWCancel }
   TFWCancel = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;

      published

       property Caption stored False;
     End;


{ TFWPreview }
   TFWPreview = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{ TFWNext }
   TFWNext = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{ TFWPrior }
   TFWPrior= class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{ TFWCopy }
   TFWCopy = class ( TFWXPButton )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;
      published
       
     End;

{ TFWInit }
   TFWInit = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{ TFWConfig }
   TFWConfig = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{ TFWImport }
   TFWImport = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;
{ TFWTrash }
   TFWTrash = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{ TFWExport }
   TFWExport = class ( TFWXPButton )
      private
      public
       procedure Loaded; override;

      published
       
     End;

{$IFDEF GROUPVIEW}

{ TFWGroupButton }

    { TFWGroupButtonActions }

    TFWGroupButtonActions = class ( TFWXPButton )
     public
      constructor Create ( AOwner : TComponent ) ; override;
     published
      property Width  default CST_WIDTH_BUTTONS_ACTIONS;
      property Height default CST_HEIGHT_BUTTONS_ACTIONS;
    end;


   { TFWBasket }

   TFWBasket = class ( TFWGroupButtonActions )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;

      published
       
       property Caption stored False;
     End;

   { TFWRecord }

   TFWRecord = class ( TFWGroupButtonActions )
      private
      public
       constructor Create ( AOwner : TComponent ) ; override;
       procedure Loaded; override;

      published
       
       property Caption stored False;
     End;

   { TFWGroupButtonMoving }

   TFWGroupButtonMoving = class ( TFWXPButton )
   public
    constructor Create ( AOwner : TComponent ) ; override;
   published
    property Width  default CST_WIDTH_BUTTONS_MOVING;
    property Height default CST_HEIGHT_BUTTONS_MOVING;
   end;
   { TFWOutSelect }
    TFWOutSelect = class ( TFWGroupButtonMoving )
       private
       public
        procedure Loaded; override;
       published
        
      End;

   { TFWOutAll }


   TFWOutAll = class ( TFWGroupButtonMoving )
      private
      public
       procedure Loaded; override;
      published
       
     End;

{ TFWInSelect }
   TFWInSelect = class ( TFWGroupButtonMoving )
      private
      public
       procedure Loaded; override;
      published
       
     End;

{ TFWInAll }
   TFWInAll = class ( TFWGroupButtonMoving )
      private
      public
       procedure Loaded; override;
      published

     End;

{$ENDIF}

implementation

uses {$IFDEF FPC}ObjInspStrConsts,
     {$ELSE}Consts, VDBConsts, {$ENDIF}
     unite_messages,
     Forms ;


{$IFNDEF FPC}
var Buttons_Appli_ResInstance             : THandle      = 0 ;
{$ENDIF}


procedure p_Load_Buttons_Appli ( const FGLyph : {$IFDEF USEJVCL}TJvPicture{$ELSE}TPicture{$ENDIF USEJVCL}; const as_Resource : String ; const acon_control :TControl);
Begin
  {$IFDEF FPC}
    FGlyph.Clear;
    FGlyph.LoadFromLazarusResource( as_Resource );
  {$ELSE}
    if ( Buttons_Appli_ResInstance = 0 ) Then
      Buttons_Appli_ResInstance:= FindResourceHInstance(HInstance);
    FGlyph.Bitmap.LoadFromResourceName(Buttons_Appli_ResInstance, as_Resource );
  {$ENDIF}
  acon_control.Invalidate;
end;

{ TFWXPButton }

{ TFWTrash }

procedure TFWTrash.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWTRASH, Self );
end;

{ TFWLoad }

constructor TFWLoad.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  caption := oiStdActFileOpenHint;
  {$ENDIF}
end;

procedure TFWLoad.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWLOAD, Self );
end;

{ TFWDocument }

procedure TFWDocument.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWDOCUMENT, Self );
end;

{ TFWDelete }

constructor TFWDelete.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := srVK_DELETE;
  {$ELSE}
//  Caption := SDeleteRecord;
  {$ENDIF}
end;

procedure TFWDelete.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWDELETE, Self );
end;

{ TFWClose }


procedure TFWClose.Click;
begin
  if not assigned ( OnClick )
  and ( Owner is TCustomForm ) then
    with Owner as TCustomForm do
     Begin
      Close;
      Exit;
     End;
  inherited;

end;

constructor TFWClose.Create(AOwner: TComponent);
begin
  inherited;
  Caption := SCloseButton;
  Width := CST_FWWIDTH_CLOSE_BUTTON;
end;

procedure TFWClose.Loaded;
begin
  inherited Loaded;
  Invalidate;
  p_Load_Buttons_Appli ( Glyph, CST_FWCLOSE, Self );
end;

{ TFWCancel }

constructor TFWCancel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := oiStdActDataSetCancel1Hint;
  {$ELSE}
  Caption := SMsgDlgCancel;
  {$ENDIF}
end;

procedure TFWCancel.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWCANCEL, Self );
end;


{ TFWOK }

constructor TFWOK.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := oisOk2;
  {$ELSE}
  Caption := SMsgDlgOK;
  {$ENDIF}
end;

procedure TFWOK.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWOK, Self );
end;

{ TFWInsert }

constructor TFWInsert.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := srVK_INSERT;
  {$ELSE}
  Caption := SInsertRecord;
  {$ENDIF}
end;

procedure TFWInsert.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWINSERT, Self );
end;
{ TFWAdd }

constructor TFWAdd.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TFWAdd.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWINSERT, Self );
end;

{ TFWSaveAs }

constructor TFWSaveAs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  caption := oiStdActFileSaveAsHint;
  {$ENDIF}
end;

procedure TFWSaveAs.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWSAVEAS, Self );
end;

{ TFWQuit }

constructor TFWQuit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := SCloseButton {$IFDEF FPC}+ ' ' + oisAll{$ENDIF};
end;

procedure TFWQuit.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWQUIT, Self );
end;


{ TFWerase }

constructor TFWErase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := oisDelete;
  {$ELSE}
  //Caption := SDeleteRecord;
  {$ENDIF}
end;

procedure TFWErase.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWERASE, Self );
end;

{ TFWPrint }

constructor TFWPrint.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := srVK_PRINT;
  {$ENDIF}
end;

procedure TFWPrint.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWPRINT, Self );
end;

{ TFWNext }

procedure TFWNext.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWNEXT, Self );
end;
{ TFWPrior }

procedure TFWPrior.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWPRIOR, Self );
end;

{ TFWPreview }

procedure TFWPreview.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWPREVIEW, Self );
end;

{ TFWInit }

procedure TFWInit.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWINIT, Self );
end;

{ TFWConfig }

procedure TFWConfig.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWCONFIG, Self );
end;

{ TFWImport }

procedure TFWImport.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWIMPORT, Self );
end;

{ TFWExport }

procedure TFWExport.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWEXPORT, Self );
end;

{ TFWCopy }

constructor TFWCopy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := oiStdActEditCopyShortHint;
  {$ENDIF}
end;

procedure TFWCopy.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWCOPY, Self );
end;


{$IFDEF GROUPVIEW}

{ TFWOutSelect }

procedure TFWOutSelect.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWOUTSELECT, Self );
end;

{ TFWBasket }

constructor TFWBasket.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := oisUndo;
  {$ELSE}
  Caption := Gs_GROUPVIEW_Basket;
  {$ENDIF}
end;

procedure TFWBasket.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWBASKET, Self );
end;

{ TFWRecord }

constructor TFWRecord.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  Caption := oisRecord;
  {$ELSE}
  Caption := Gs_GROUPVIEW_Record;
  {$ENDIF}
end;

procedure TFWRecord.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWOK, Self );
end;


{ TFWOutAll }

procedure TFWOutAll.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWOUTALL, Self );
end;

{ TFWInSelect }

procedure TFWInSelect.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWINSELECT, Self );
end;

{ TFWInAll }

procedure TFWInAll.Loaded;
begin
  inherited Loaded;
  p_Load_Buttons_Appli ( Glyph, CST_FWINALL, Self );
end;

{ TFWGroupButtonActions }

constructor TFWGroupButtonActions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width  := CST_WIDTH_BUTTONS_ACTIONS;
  Height := CST_HEIGHT_BUTTONS_ACTIONS;
end;

{ TFWGroupButtonMoving }

constructor TFWGroupButtonMoving.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width  := CST_WIDTH_BUTTONS_MOVING;
  Height := CST_HEIGHT_BUTTONS_MOVING;
  Caption := '';
end;


{$ENDIF}



initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_buttons_appli  );
{$ENDIF}
{$IFDEF FPC}
  {$I u_buttons_appli.lrs}
{$ENDIF}

end.

