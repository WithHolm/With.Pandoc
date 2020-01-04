function Set-PandocMetadata {
    [CmdletBinding()]
    param (
        [hashtable]$Arguments,
        $metadata
    )
    
    begin {
        
    }
    
    process {
        #If its a hashtable, add it directly to arguments
        if ($Metadata -is [hashtable])
        {
            $arguments."--Metadata" = "$($Metadata.Keys|%{"$_='$($Metadata[$_])'"})"
        }
        #if its defined as a fileinfo, test if file is there
        elseif ($Metadata -is [System.IO.FileInfo])
        {
            if (!$Metadata.exists)
            {
                Throw "Cannot find file $($metadata.fullname)"
            }
            $arguments."--Metadata-file" = "='$($metadata.fullname)'"
            # $Arguments += "--metadata-file='$($metadata.fullname)'"
        }
        elseif ($Metadata -is [string])
        {
            if (!test-path $Metadata)
            {
                Throw "Cannot find "
            }
        }
        else
        {
            Throw "Cannot process metadata $metadata"
        }
    }
    
    end {
        
    }
}