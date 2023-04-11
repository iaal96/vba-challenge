Attribute VB_Name = "Module1"
Sub Challenge2()
Dim CurrentWs As Worksheet
Dim Results As Boolean
Header = True
'loop through worksheets
For Each CurrentWs In Worksheets
'make variables
Dim Ticker_Name As String
Dim Total_Volume As Double
Total_Volume = 0
Dim Opening_Price As Double
Opening_Price = 0
Dim Closing_Price As Double
Closing_Price = 0
Dim Yearly_Change As Double
Yearly_Change = 0
Dim Yearly_Percent As Double
Yearly_Percent = 0
Dim Bonus_Increase As Double
Bonus_Increase = 0
Dim Bonus_Decrease As Double
Bonus_Decrease = 0
Dim Greatest_Volume As Double
Greatest_Volume = 0
Dim Bonus_Increase_Ticker As String
Dim Bonus_Decrease_Ticker As String
Dim Greatest_Volume_Ticker As String
Dim LastRow As Long
Dim i As Long

'make location for tickers
Dim Summary_Table_Row As Long
Summary_Table_Row = 2
'get last row from worksheets
LastRow = CurrentWs.Cells(Rows.Count, 1).End(xlUp).Row
'create headers
If Need_Summary_Table_Header Then
    CurrentWs.Range("I1").Value = "Ticker"
    CurrentWs.Range("J1").Value = "Yearly Change"
    CurrentWs.Range("K1").Value = "Percent Change"
    CurrentWs.Range("L1").Value = "Total Stock Volume"
    CurrentWs.Range("O2").Value = "Greatest % Increase"
    CurrentWs.Range("O3").Value = "Greatest % Decrease"
    CurrentWs.Range("O4").Value = "Greatest Total Volume"
    CurrentWs.Range("P1").Value = "Ticker"
    CurrentWs.Range("Q1").Value = "Value"
Else
    Need_Summary_Table_Header = True
End If
'get first opening price
Opening_Price = CurrentWs.Cells(2, 3).Value
For i = 2 To LastRow
If CurrentWs.Cells(i + 1, 1).Value <> CurrentWs.Cells(i, 1).Value Then
'set ticker name
    Ticker_Name = CurrentWs.Cells(i, 1).Value
'calculate yearly change and closing price
    Closing_Price = CurrentWs.Cells(i, 6).Value
    Yearly_Change = (Closing_Price - Opening_Price)
    If Opening_Price <> 0 Then
        Yearly_Percent = (Yearly_Change / Opening_Price) * 100
   End If
   
Total_Volume = Total_Volume + CurrentWs.Cells(i, 7).Value

'place values in summary table
CurrentWs.Range("I" & Summary_Table_Row).Value = Ticker_Name
CurrentWs.Range("L" & Summary_Table_Row).Value = Total_Volume
CurrentWs.Range("J" & Summary_Table_Row).Value = Yearly_Change
'percent sign
CurrentWs.Range("K" & Summary_Table_Row).Value = (CStr(Yearly_Percent) & "%")
'set colors
If (Yearly_Change > 0) Then
    CurrentWs.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
ElseIf (Yearly_Change <= 0) Then
    CurrentWs.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
End If

Summary_Table_Row = Summary_Table_Row + 1
'calculation of bonus values
Bonus_Increase = WorksheetFunction.Max(CurrentWs.Range("K:K"))
Bonus_Decrease = WorksheetFunction.Min(CurrentWs.Range("K:K"))
Greatest_Volume = WorksheetFunction.Max(CurrentWs.Range("L:L"))
'put bonus values in summary table
    CurrentWs.Range("Q2").Value = (CStr(Bonus_Increase) & "%")
    CurrentWs.Range("Q3").Value = (CStr(Bonus_Decrease) & "%")
    CurrentWs.Range("P2").Value = Bonus_Increase_Ticker
    CurrentWs.Range("P3").Value = Bonus_Decrease_Ticker
    CurrentWs.Range("Q4").Value = Greatest_Volume
    CurrentWs.Range("P4").Value = Greatest_Volume_Ticker
    
Yearly_Percent = 0
Total_Volume = 0
Yearly_Change = 0
Closing_Price = 0
Opening_Price = CurrentWs.Cells(i + 1, 3).Value
'add stock volume cells to stock volume
Else
Total_Volume = Total_Volume + CurrentWs.Cells(i, 7).Value

End If

Next i
    
Next CurrentWs
End Sub
