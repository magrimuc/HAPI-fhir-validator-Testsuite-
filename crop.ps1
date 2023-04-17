# Automated test in 3 parts: arrange act assert
#ARRANGE
# Daten aus Excel Datei auslesen
$pwd = &"pwd"
$dateipfad = Join-String -Strings $pwd.Path,.\HAPI-fhir-validator-Testsuite-\Testfälle.xlsx
$tabelle = "Test"
[int]$zeile = 2
[int]$spalte = 1

$Excel = New-Object -ComObject excel.application # Excel starten
$Excel.Visible = $false
$Workbook = $Excel.Workbooks.Open($dateipfad)
$Table =$workbook.Worksheets.Item($tabelle)
do {
#ACT
$Testfall = Join-String -Strings $pwd.Path, $Table.Cells.Item($zeile,$spalte).Text

#$erg = $Table.Cells.Item($zeile,$spalte+2)
#$er= Split-String -Input $erg.Text -Separator "--"
#Write-Output $er[1]
#$Table.Cells.Item($zeile,$spalte+2) = $er[1]

$erg = $Table.Cells.Item($zeile,$spalte+3)
$er= Split-String -Input $erg.Text -Separator "--"
Write-Output $er[1]
$Table.Cells.Item($zeile,$spalte+3) = $er[1]

$zeile++

}
while($Table.Cells.Item($zeile,$spalte).Text.Length -gt 0)

$Workbook.Save()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Workbook)

$excel.DisplayAlerts = 'False'

$Excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)

#EOF
#ASSERTIONs in Excel