unit AzuliaPicClip;

interface

uses Classes, Controls, WinTypes, Graphics, StdCtrls, ExtCtrls;

type
TPicClip = class(TImage)
private
   FRows:Integer;
   FCols:Integer;
   FPicture:TPicture;
   function GetCell (Index:Integer):TPicture;
public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy;override;
   property GraphicCell[Index:Integer]:TPicture read GetCell;
published
   property Rows:Integer read FRows write FRows;
   property Cols:Integer read FCols write FCols;
end;

procedure Register;

implementation

constructor TPicClip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
  Visible := False;
end;

destructor TPicClip.Destroy;
begin
   FPicture.Destroy;
   inherited Destroy;
end;

function TPicClip.GetCell (Index:Integer):TPicture;
var
   BWidth, BHeight:Integer;
   SrcR, DestR:TRect;
begin
   BWidth := Picture.Width div FCols;
   BHeight := Picture.Height div FRows;

   DestR.Left := 0;
   DestR.Top := 0;
   DestR.Right := BWidth;
   DestR.Bottom := BHeight;

   SrcR.Left := (Index mod Cols) * BWidth;
   SrcR.Top := (Index div Cols) * BHeight;
   SrcR.Right := SrcR.Left + BWidth;
   SrcR.Bottom := SrcR.Top + BHeight;

   FPicture.Bitmap.Width := BWidth;
   FPicture.Bitmap.Height := BHeight;
   FPicture.Bitmap.Canvas.CopyRect (DestR, Canvas, SrcR);

    GetCell := FPicture;
end;

procedure Register;
begin
  RegisterComponents('Azulia Designs', [TPicClip] );
end;

end.
