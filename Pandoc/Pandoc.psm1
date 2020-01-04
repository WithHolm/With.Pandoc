$RequiredVersion = [version]"2.9.1"
# $errmsg = "Pandoc not installed. please install latest version https://github.com/jgm/pandoc/releases/latest"
try{
    $pandoc = get-command pandoc
    $version = [version](pandoc --version)[0].split(" ")[-1]
    if($version.ToString() -lt $RequiredVersion.ToString())
    {
        Write-warning "This module was created using $RequiredVersion, but you have version $version. some features might not work"
    }
}
catch{
    Throw "Pandoc not installed. please install latest version https://github.com/jgm/pandoc/releases/latest"
}

gci "$PSScriptRoot\functions" -Recurse -Filter "*.public.ps1"|%{
    . $_.FullName
}