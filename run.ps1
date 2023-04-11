# Automated test in 3 parts: arrange act assert
#ARRANGE
#PATHs to java (line 19), reference-validator (line 19) and Testfälle.xls (idnk) (saved to ~ e.g.) unfortunatelly still a mess
# Daten aus Excel Datei auslesen
$pwd = &"pwd"
$dateipfad = Join-String -Strings $pwd.Path,\HAPI-fhir-validator-Testsuite-\Testfälle.xlsx
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

$erg = C:\W2\jrew\bin\java -jar C:\Users\mnkuemme\Documents\eRez\github\reference-validator-cli-1.0.1.jar $Testfall | Select-Object -Last 1
Write-Output $erg 

$Table.Cells.Item($zeile,$spalte+3) = $erg

$zeile++

}
while($Table.Cells.Item($zeile,$spalte).Text.Length -gt 0)

$Workbook.Save()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Workbook)

$Excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)

#EOF
#ASSERTIONs in Excel
