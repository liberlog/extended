﻿// unité contenant des fonctions de traitements de chaine
unit fonctions_system;

interface

{$I ..\Compilers.inc}
{$I ..\extends.inc}

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

uses
{$IFDEF FPC}
  LCLIntf,
{$ELSE}
  Windows,
{$ENDIF}
  Forms, SysUtils,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  StrUtils, Classes ;

{$IFDEF DELPHI}
const
  DirectorySeparator = '\' ;
{$ENDIF}


function fs_ExtractFileNameOnly ( const as_Path : String ): String;
function fs_GetNameSoft : String;
// Retourne le nom d'utilisateur (string) de la session WINDOWS
function fs_GetUserSession: string;

// Retourne le nom d'ordinateur (string)
function fs_GetComputerName: string;
{$IFNDEF FPC}
function GetAppConfigDir ( const Global : Boolean ): string;
function GetWinDir ( const CSIDL : Integer ) : String ;
{$ENDIF}
const
  {$IFDEF LINUX}
  SYSDIR_CONFIGDIR_NAME = '.config';
  {$ENDIF}
  {$IFDEF VERSIONS}
  gVer_fonction_system : T_Version = ( Component : 'Gestion des chaînes' ; FileUnit : 'fonctions_string' ;
                        			                 Owner : 'Matthieu Giroux' ;
                        			                 Comment : 'Fonctions de traduction et de formatage des chaînes.' ;
                        			                 BugsStory : 'Version 1.0.0.0 : Creating from fonctions_string.';
                        			                 UnitType : 1 ;
                        			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

implementation


{$IFDEF FPC}
uses
  LCLType, FileUtil ;
{$ENDIF}


////////////////////////////////////////////////////////////////////////////////
// Lit le nom de la session
////////////////////////////////////////////////////////////////////////////////
function fs_GetUserSession: string;
{$IFDEF FPC}
Begin
 Result := 'config';
{$ELSE}
var
  Buffer: array[0..255] of char;    // tableau de 255 caracteres
  BufferSize: DWORD;                // nombre 16 bits non signé  VL_B_Resultat : Boolean;
begin
  BufferSize := sizeOf(Buffer); // (= 256)
  if GetUserName(@buffer, BufferSize) then ; // (lpBuffer: PChar; var nSize: DWORD)
  result := Buffer; // MEP utilisateur
{$ENDIF}
end;

////////////////////////////////////////////////////////////////////////////////
// Lit le nom de la machine
////////////////////////////////////////////////////////////////////////////////
function fs_GetComputerName : string;
{$IFDEF FPC}
Begin
 //    Result := GetComputerName;
 Result := '';
{$ELSE}
var
  Buffer: array[0..255] of char;    // tableau de 255 caracteres
  BufferSize: DWORD;                // nombre 16 bits non signé  VL_B_Resultat : Boolean;
begin
  BufferSize := sizeOf(Buffer); // (= 256)
  if GetComputerName(@buffer, BufferSize) then ; // (lpBuffer: PChar; var nSize: DWORD)
  result := Buffer; // MEP utilisateur
{$ENDIF}
end;

function fs_ExtractFileNameOnly ( const as_Path : String ): String;
Begin
  Result := ExtractFileName(as_path);
  Result :=copy ( Result, 1 , length ( Result ) - length( ExtractFileExt(Result)));
End;


{$IFNDEF FPC}
function GetAppConfigDir ( const Global : Boolean ): string;
 begin
   if Global
    Then Result := GetWinDir ( CSIDL_COMMON_APPDATA )
    Else Result := GetWinDir ( CSIDL_APPDATA );
   Result := Result + DirectorySeparator + fs_ExtractFileNameOnly ( Application.ExeName );
 end;

function GetWinDir ( const CSIDL : Integer ) : string;
 var
    path: array[0..Max_Path] of Char;
 begin
    ShGetSpecialFolderPath(0, path, CSIDL, False) ;
    Result := Path;
 end;
{$ENDIF}

function fs_GetNameSoft : String;
var li_Pos : Integer;
Begin
  Result := ExtractFileName(Application.ExeName);
  li_Pos := Pos ( '.', Result );
  if ( li_Pos > 0 ) then
    Begin
      while PosEx ( '.', Result, li_Pos + 1 )> 0 do
        li_Pos := PosEx ( '.', Result, li_Pos + 1 );
      Result := Copy ( Result, 1, PosEx ( '.', Result, li_Pos )-1 );
    End;
End;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonction_system );
{$ENDIF}
end.

