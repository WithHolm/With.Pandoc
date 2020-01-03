function Convert-WithPandoc {
    [CmdletBinding()]
    param (
        [parameter(
            Mandatory,
            HelpMessage="Fileinfo,Directoryinfo,File Fullname,URL",
            ValueFromPipeline)]
        $inputobject,

        [ValidateSet(
            'commonmark', 'creole', 
            'docbook', 'docx', 
            'dokuwiki', 'epub', 
            'fb2', 'gfm', 
            'haddock', 'html', 
            'ipynb', 'jats', 
            'jira', 'json', 
            'latex', 'man', 
            'markdown', 'markdown_github', 
            'markdown_mmd', 'markdown_phpextra', 
            'markdown_strict', 'mediawiki', 
            'muse', 'native', 
            'odt', 'opml', 
            'org', 'rst', 
            't2t', 'textile', 
            'tikiwiki', 'twiki', 'vimwiki'
        )]
        $InputType,
        
        # [String]$Datatype,
        
        [ValidateSet(
            'asciidoc', 'asciidoctor', 
            'beamer', 'commonmark', 
            'context', 'docbook', 
            'docbook4', 'docbook5', 
            'docx', 'dokuwiki', 
            'dzslides', 'epub', 
            'epub2', 'epub3', 
            'fb2', 'gfm', 
            'haddock', 'html', 
            'html4', 'html5', 
            'icml', 'ipynb', 
            'jats', 'jira', 
            'json', 'latex', 
            'man', 'markdown', 
            'markdown_github', 
            'markdown_mmd', 'markdown_phpextra', 
            'markdown_strict', 'mediawiki', 
            'ms', 'muse', 
            'native', 'odt', 
            'opendocument', 'opml', 
            'org', 'pdf', 
            'plain', 'pptx', 
            'revealjs', 'rst', 
            'rtf', 's5', 
            'slideous', 'slidy', 
            'tei', 'texinfo', 
            'textile', 'xwiki', 
            'zimwiki'
        )]
        [String]$Outputtype,
        # [parameter(Mandatory,HelpMessage="supports only html or docx")]
        # [System.IO.FileInfo]$Outputobject,

        [string[]]$Sort,

        [switch]$TOC,

        [int]$TocDepth,

        $Metadata
    )
    
    begin {
        $Arguments = @()
        if($Metadata)
        {
            if($Metadata -is [hashtable])
            {
                $arguments += "--metadata $($Metadata.Keys|%{"$_='$($Metadata[$_])'"})"
            }
            elseif ($Metadata -is [System.IO.FileInfo]) {
                if(!$Metadata.exists)
                {

                }
            }
        }

        $Source = @()

        if($TocDepth -and !$TOC)
        {
            Write-Warning "TocDepth is only viable if toc is enabled"
        }
    }
    
    process {
        Foreach($item in $inputobject)
        {
            if($item -is [System.IO.FileInfo])
            {

                Write-Verbose "File $($item.Fullname)"
                $source += $item.Fullname
            }
            elseif($item -is [uri])
            {
                Write-Verbose "URI $($item.OriginalString)"
                $source = $item.OriginalString
            }
            elseif($item -is [string])
            {
                if($item -like "http*")
                {
                    Write-Verbose "URL: $item"
                    $Source += $item
                }
                elseif(test-path $item)
                {
                    Write-Verbose "File: $item"
                    $Source += $item

                }
                else {
                    throw "Unknown item '$item'"
                }
            }
            else {
                Write-warning "Not counting $item. its not a FileInfo, URI or a string to a filepath"
            }
        }
    }
    
    end {
        #Sort
        if($Sort)
        {
            $UsingSource = @()
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
        else {
            $UsingSource = $Source
        }

        $UsingSource = $UsingSource|%{
            "'$_'"
        }

        # #outfiletypes
        
        if($OutFile.Extension -notin @("html","docx"))
        {

        }

        $Arguments = @(
            "-s $($Source -join " ")"
        )
        if($TOC)
        {
            $Arguments += "--table-of-contents"
        }

        $Arguments += "-o '$outfile'"
        if($VerbosePreference -eq "Continue")
        {
            $Arguments += "--verbose"
        }

        # if($Metadata)
        # {
        #     $Arguments += "--metadata $($Metadata.Keys|%{"$_='$($Metadata[$_])'"})"
        # }
        Write-Verbose ($Arguments -join " ")

        "pandoc $($arguments -join " ")"|Invoke-Expression -ov proc|Out-Null
        $proc|%{
            Write-Host "hey $_"
            if($_ -like "[Warning]*")
            {
                Write-warning $_
            }
            elseif($_ -like "*--metadata*")
            {
                Write-Verbose "$_ Powershell: -Metadata @{key='Value'}"
            }
            else {
                Write-Information $_
            }
        }
    }
}

get-item "C:\git\With.Pandoc\README.md"|Convert-WithPandoc


<#
  -f FORMAT, -r FORMAT  --from=FORMAT, --read=FORMAT
  -t FORMAT, -w FORMAT  --to=FORMAT, --write=FORMAT
  -o FILE               --output=FILE
                        --data-dir=DIRECTORY
  -M KEY[:VALUE]        --metadata=KEY[:VALUE]
                        --metadata-file=FILE
  -d FILE               --defaults=FILE
                        --file-scope
  -s                    --standalone
                        --template=FILE
  -V KEY[:VALUE]        --variable=KEY[:VALUE]
                        --wrap=auto|none|preserve
                        --ascii
                        --toc, --table-of-contents
                        --toc-depth=NUMBER
  -N                    --number-sections
                        --number-offset=NUMBERS
                        --top-level-division=section|chapter|part
                        --extract-media=PATH
                        --resource-path=SEARCHPATH
  -H FILE               --include-in-header=FILE
  -B FILE               --include-before-body=FILE
  -A FILE               --include-after-body=FILE
                        --no-highlight
                        --highlight-style=STYLE|FILE
                        --syntax-definition=FILE
                        --dpi=NUMBER
                        --eol=crlf|lf|native
                        --columns=NUMBER
  -p                    --preserve-tabs
                        --tab-stop=NUMBER
                        --pdf-engine=PROGRAM
                        --pdf-engine-opt=STRING
                        --reference-doc=FILE
                        --self-contained
                        --request-header=NAME:VALUE
                        --abbreviations=FILE
                        --indented-code-classes=STRING
                        --default-image-extension=extension
  -F PROGRAM            --filter=PROGRAM
  -L SCRIPTPATH         --lua-filter=SCRIPTPATH
                        --shift-heading-level-by=NUMBER
                        --base-header-level=NUMBER
                        --strip-empty-paragraphs
                        --track-changes=accept|reject|all
                        --strip-comments
                        --reference-links
                        --reference-location=block|section|document
                        --atx-headers
                        --listings
  -i                    --incremental
                        --slide-level=NUMBER
                        --section-divs
                        --html-q-tags
                        --email-obfuscation=none|javascript|references
                        --id-prefix=STRING
  -T STRING             --title-prefix=STRING
  -c URL                --css=URL
                        --epub-subdirectory=DIRNAME
                        --epub-cover-image=FILE
                        --epub-metadata=FILE
                        --epub-embed-font=FILE
                        --epub-chapter-level=NUMBER
                        --ipynb-output=all|none|best
                        --bibliography=FILE
                        --csl=FILE
                        --citation-abbreviations=FILE
                        --natbib
                        --biblatex
                        --mathml
                        --webtex[=URL]
                        --mathjax[=URL]
                        --katex[=URL]
                        --gladtex
                        --trace
                        --dump-args
                        --ignore-args
                        --verbose
                        --quiet
                        --fail-if-warnings
                        --log=FILE
                        --bash-completion
                        --list-input-formats
                        --list-output-formats
                        --list-extensions[=FORMAT]
                        --list-highlight-languages
                        --list-highlight-styles
  -D FORMAT             --print-default-template=FORMAT
                        --print-default-data-file=FILE
                        --print-highlight-style=STYLE|FILE
  -v                    --version
  -h                    --help
#>