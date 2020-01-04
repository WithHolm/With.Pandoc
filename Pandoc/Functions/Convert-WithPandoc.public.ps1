function Convert-WithPandoc
{
    [CmdletBinding()]
    param (
        [parameter(
            Mandatory,
            HelpMessage = "Fileinfo,Directoryinfo,File Fullname,URL",
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
        
        [string[]]$InputGrouping,

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

        [switch]$ExtractMedia,

        [String]$Mediapath,

        [switch]$TOC,

        [int]$TocDepth,

        [switch]$PreserveTabs,

        [parameter(
            HelpMessage = "Hashtable or FileInfo/Path to Yaml/Json file with metadata"
        )]
        $Metadata,

        $DefaultsFile
    )
    
    begin
    {
        $Arguments = @{}

        if($PreserveTabs)
        {
            $Arguments."--preserve-tabs" = ""
        }

        if ($TocDepth -and !$TOC)
        {
            Write-Warning "TocDepth is only viable if toc is enabled"
        }

        if($InputType)
        {
            $Arguments."--read" = $InputType 
        }
        
        if($Outputtype)
        {
            $Arguments."--write" = $Outputtype 
        }
        # if($ExtractMedia)
        # {

        # }
    }
    
    process
    {
        $source += Merge-PandocSources -inputobject $inputobject 
    }
    
    end
    {
        if(!$SourceGrouping)
        {
            $InputGrouping = "*"
        }
        $source = Group-PandocSources -Source $Source -Grouping $InputGrouping

        #If Metadata is defined
        if ($Metadata)
        {
            Set-PandocMetadata -Arguments $Arguments -metadata $Metadata
        }

        #Set source
        # $Arguments."-s" = $($Source -join " ")


        if ($TOC)
        {
            $Arguments."--table-of-contents" = ""
        }

        if ($VerbosePreference -eq "Continue")
        {
            $Arguments."--verbose" = ""
        }

        # Write-Verbose $($Arguments|ConvertTo-Json)
        

        $Arg = @()
        $Arguments.Keys|%{
            if([string]::IsNullOrEmpty($Arguments.$_))
            {
                $arg += $_
            }
            else {
                $arg += "$_=$($Arguments.$_)"
            }
        }
        $Arg += $($Source -join " ")
        Write-Verbose "$Arg"

        Start-Process (get-command pandoc).Path -ArgumentList $Arg -Wait -NoNewWindow -Verbose # -RedirectStandardOutput proc -RedirectStandardError procerr 

        if($procerr)
        {
            $procerr|%{
                Write-Error $_
            }
        }

        if($proc)
        {
            $proc|%{
                Write-Verbose $_
            }
        }
        # [void]("pandoc $($Arg -join " ")" | Invoke-Expression -ov proc)
        # $proc | % {
        #     Write-Host "hey $_"
        #     if ($_ -like "[Warning]*")
        #     {
        #         Write-warning $_
        #     }
        #     elseif ($_ -like "*--metadata*")
        #     {
        #         Write-Verbose "$_ Powershell: -Metadata @{key='Value'}"
        #     }
        #     else
        #     {
        #         Write-Information $_
        #     }
        # }
    }
}

# get-item "C:\git\With.Pandoc\README.md"|Convert-WithPandoc -Verbose


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