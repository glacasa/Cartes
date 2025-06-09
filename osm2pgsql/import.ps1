$version = "2.1.1"
$region = "midi-pyrenees"


$zipPath = "$PSScriptRoot\osm2pgsql-$version.zip"
if (-Not (Test-Path $zipPath)) {
    Invoke-WebRequest -Uri https://osm2pgsql.org/download/windows/osm2pgsql-$version-x64.zip -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $PSScriptRoot -Force
}

$regionPath = "$PSScriptRoot\$region.osm.pbf"
if (-Not (Test-Path $regionPath)) {
     Invoke-WebRequest -Uri https://download.geofabrik.de/europe/france/$region-latest.osm.pbf -OutFile $regionPath
}

$dbConnection = "postgres://postgis:postgis@localhost:5432/cartes"
& "$PSScriptRoot\osm2pgsql-bin\osm2pgsql.exe" --create --database=$dbConnection --output=flex --style="$PSScriptRoot/import-osm.lua" $regionPath
