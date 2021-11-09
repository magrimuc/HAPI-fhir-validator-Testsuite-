# Automated test in 3 parts: arrange act assert
#ARRANGE
# Daten aus Excel Datei auslesen
$pwd = &"pwd"
$dateipfad = Join-String -Strings $pwd.Path,\testfälle\Testfälle.xlsx
$tabelle = "Test"
[int]$zeile = 2
[int]$spalte = 1

$Excel = New-Object -ComObject excel.application # Excel starten
$Excel.Visible = $false
$Workbook = $Excel.Workbooks.Open($dateipfad)
$Table =$workbook.Worksheets.Item($tabelle)
do {
#ACT
$Testfall = $Table.Cells.Item($zeile,$spalte).Text
$TestConsoleOut =
$argList = Join-String -Strings "-jar ..\reference-validator-cli-0.1.0-SNAPSHOT.jar ",testfälle\,$Testfall
$ret = Start-Process -FilePath java -ArgumentList $argList -RedirectStandardOutput ( Join-String -Strings out\$Testfall,out.txt) -wait

Out-String -InputObject $Testfall
$zeile++
#ASSERT
#Compare-Object (Get-Content IST) (Get-Content SOLL)
(get-content ( Join-String -Strings $Testfall,out.txt))
#(get-content ( Join-String -Strings testfälle\,SOLL,$Testfall,out.txt))

#Compare-Object -DifferenceObject (get-content ( Join-String -Strings $Testfall,out.txt)) -ReferenceObject (get-content ( Join-String -Strings testfälle\,SOLL,$Testfall,out.txt))
# TODO: Excel write return value to ($zeile, $spalte +2)
}
while($Table.Cells.Item($zeile,$spalte).Text.Length -gt 0)

$Excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)

#EOF
