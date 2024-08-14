program Acervo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, pckUserControlDesign, pckUserControlRuntime, runtimetypeinfocontrols,
  printer4lazarus, datetimectrls, lazcontrols, rxnew, rx, zcomponent,
  untfrmprincipal, untfrmusuario, untfrmlogin, untfrmcadastro, untfrmrelatorios,
  untdmConexao, untfrmpesquisa, untfrmlistadesejos
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.

