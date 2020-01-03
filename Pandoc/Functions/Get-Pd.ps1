function Get-PdExe {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        #If Pandoc.exe is not set
        if(!$global:Pandoc.Exe)
        {
            #Tests if its part of $env:path
            try{
                $pandoc = Get-Command pandoc
            }catch{
                Throw "Pandoc is not avalible. please download pandoc or give me a location for pandoc with 'set-pandocexe -path'"
            }
        }

        # if($env:path -like "*pandoc*")
        # {
        #     $env:path.Split(";")|?{$_ -like "*pandoc*"}
        # }
        # else {
        #     $env:path.Split(";")|%{
    
        #     }
        # }



        try{
            $Pd = pandoc --version
        }
        catch{
            Throw "Pandoc is not avalible. please install"
        }

        $verison = [version]$pd[0].split(" ")[-1]
        $verison
        


        @{
            PandocExe = [version]$pd[0].split(" ")[-1]
            Types = $pd[1].split(" ")
        }
    }
    
    end {
        
    }
}

Get-PdVersion