function Merge-PandocSources {
    [CmdletBinding()]
    [Outputtype([array])]
    param (
        $inputobject
    )
    
    begin {
        
    }
    
    process {
        Foreach($item in $inputobject)
        {
            if($item -is [System.IO.FileInfo])
            {

                Write-Verbose "File $($item.Fullname)"
                write-output $item.Fullname
            }
            elseif($item -is [uri])
            {
                Write-Verbose "URI $($item.OriginalString)"
                write-output $item.OriginalString
            }
            elseif($item -is [string])
            {
                if($item -like "http*")
                {
                    Write-Verbose "URL: $item"
                    write-output $item
                }
                elseif(test-path $item)
                {
                    Write-Verbose "File: $item"
                    write-output $item

                }
                else {
                    throw "Unknown item '$item'. if its a uri, please use http/https at the start"
                }
            }
            else {
                Write-warning "Not counting $item. its not a FileInfo, URI or a string to a filepath"
            }
        }
    }
    
    end {
        
    }
}