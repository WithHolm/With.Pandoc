function Group-PandocSources {
    [CmdletBinding()]
    param (
        [String[]]$Source,
        [String[]]$Grouping
    )
    
    begin {
        
    }
    
    process {
        if ($Sort)
        {
            Foreach($S in $sort)
            {
                $UsingSource += $Source|Where-Object{$_.name -like $S}
            }
            if($UsingSource.count -ne $Source.count)
            {
                $UsingSource += $Source
            }
    
            $UsingSource = $UsingSource|Select-Object -Unique
        }
        else
        {
            $UsingSource = $Source
        }
        $UsingSource = $UsingSource|%{
            "'$_'"
        }
        return $UsingSource


    }
    
    end {
        
    }
}