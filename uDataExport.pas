﻿unit uDataExport;

interface

uses cxGrid;

  procedure cxGridToExcelWithImages( const strDocument: String; cxGrid: TcxGrid; AExpand: Boolean );

implementation

uses cxGridExportLink, ComObj, uFileSystem, Windows, uOMSDialogs;

procedure cxGridToExcelWithImages( const strDocument: String; cxGrid: TcxGrid; AExpand: Boolean );
var
  ExcelApp, Workbook: Variant;
  fileName: String;
//  FileTemplate: String;
begin
  ExcelApp := CreateOleObject('Excel.Application');

  fileName := GetTempDirectory + strDocument + '.xlsx';
  DeleteFile(PWideChar(WideString( fileName )));
//  FileTemplate := GetTempDirectory + strDocument + '.xltx';
//  DeleteFile(PWideChar(WideString(FileTemplate)));

  ExcelApp.Application.EnableEvents := False;

  try
    ExportGridToXLSX(fileName, cxGrid, AExpand, True, False, 'xlsx');
    Workbook := ExcelApp.WorkBooks.Add( fileName );
  except
    ShowError('Произошла ошибка при выгрузке в формат XLSX. Обратитесь к программисту.');
  end;

{
  Workbook.SaveAs(FileTemplate, 54);
  Workbook.Close(0);
  Workbook := ExcelApp.WorkBooks.Add( FileTemplate );
}
  ExcelApp.Application.EnableEvents := True;
  ExcelApp.Visible := True;
end;

end.
