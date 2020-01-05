function Convert-WithPandoc
{
    [CmdletBinding()]
    param (
        
        [parameter(
            Mandatory,
            HelpMessage = "Fileinfo,Directoryinfo,File Fullname,URL",
            ValueFromPipeline)]
        $inputobject,

        [parameter(
            HelpMessage = "What will the input read as. if not defined, it will be guessed by pandoc"
        )]
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

        [ValidateSet(
            '-abbreviations', '+all_symbols_escapable', 
            '-amuse', '-angle_brackets_escapable', 
            '-ascii_identifiers', '+auto_identifiers', 
            '-autolink_bare_uris', '+backtick_code_blocks', 
            '+blank_before_blockquote', '+blank_before_header', 
            '+bracketed_spans', '+citations', 
            '-compact_definition_lists', '+definition_lists', 
            '-east_asian_line_breaks', '-emoji', 
            '-empty_paragraphs', '-epub_html_exts', 
            '+escaped_line_breaks', '+example_lists', 
            '+fancy_lists', '+fenced_code_attributes', 
            '+fenced_code_blocks', '+fenced_divs', 
            '+footnotes', '-four_space_rule', 
            '-gfm_auto_identifiers', '+grid_tables', 
            '-hard_line_breaks', '+header_attributes', 
            '-ignore_line_breaks', '+implicit_figures', 
            '+implicit_header_references', '+inline_code_attributes', 
            '+inline_notes', '+intraword_underscores', 
            '+latex_macros', '+line_blocks', 
            '+link_attributes', '-lists_without_preceding_blankline', 
            '-literate_haskell', '-markdown_attribute', 
            '+markdown_in_html_blocks', '-mmd_header_identifiers', 
            '-mmd_link_attributes', '-mmd_title_block', 
            '+multiline_tables', '+native_divs', 
            '+native_spans', '-native_numbering', 
            '-ntb', '-old_dashes', '+pandoc_title_block', 
            '+pipe_tables', '+raw_attribute', 
            '+raw_html', '+raw_tex', 
            '+shortcut_reference_links', '+simple_tables', 
            '+smart', '+space_in_atx_header', 
            '-spaced_reference_links', '+startnum', 
            '+strikeout', '+subscript', 
            '+superscript', '-styles', 
            '+task_lists', '+table_captions', 
            '+tex_math_dollars', '-tex_math_double_backslash', 
            '-tex_math_single_backslash', '+yaml_metadata_block', 
            '-gutenberg'
        )]
        [parameter(
            HelpMessage = "Extensions to use when reading. 
            Extensions with '+' is enabling a extension, and '-' is disabling extension. 
            there is currently no checking of if the extension selected is supported for type. 
            Can only be chosen if type is chosen.
            https://pandoc.org/MANUAL.html#extensions"
        )]
        [string[]]$InputTypeExtension,


        
        [parameter(
            HelpMessage = ""
        )]
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
        [String]$OutputType,

        [ValidateSet(
            '-abbreviations', '+all_symbols_escapable', 
            '-amuse', '-angle_brackets_escapable', 
            '-ascii_identifiers', '+auto_identifiers', 
            '-autolink_bare_uris', '+backtick_code_blocks', 
            '+blank_before_blockquote', '+blank_before_header', 
            '+bracketed_spans', '+citations', 
            '-compact_definition_lists', '+definition_lists', 
            '-east_asian_line_breaks', '-emoji', 
            '-empty_paragraphs', '-epub_html_exts', 
            '+escaped_line_breaks', '+example_lists', 
            '+fancy_lists', '+fenced_code_attributes', 
            '+fenced_code_blocks', '+fenced_divs', 
            '+footnotes', '-four_space_rule', 
            '-gfm_auto_identifiers', '+grid_tables', 
            '-hard_line_breaks', '+header_attributes', 
            '-ignore_line_breaks', '+implicit_figures', 
            '+implicit_header_references', '+inline_code_attributes', 
            '+inline_notes', '+intraword_underscores', 
            '+latex_macros', '+line_blocks', 
            '+link_attributes', '-lists_without_preceding_blankline', 
            '-literate_haskell', '-markdown_attribute', 
            '+markdown_in_html_blocks', '-mmd_header_identifiers', 
            '-mmd_link_attributes', '-mmd_title_block', 
            '+multiline_tables', '+native_divs', 
            '+native_spans', '-native_numbering', 
            '-ntb', '-old_dashes', '+pandoc_title_block', 
            '+pipe_tables', '+raw_attribute', 
            '+raw_html', '+raw_tex', 
            '+shortcut_reference_links', '+simple_tables', 
            '+smart', '+space_in_atx_header', 
            '-spaced_reference_links', '+startnum', 
            '+strikeout', '+subscript', 
            '+superscript', '-styles', 
            '+task_lists', '+table_captions', 
            '+tex_math_dollars', '-tex_math_double_backslash', 
            '-tex_math_single_backslash', '+yaml_metadata_block', 
            '-gutenberg'
        )]
        [parameter(
            HelpMessage = "Extensions to use when reading. 
            Extensions with '+' is enabling a extension, and '-' is disabling extension. 
            there is currently no checking of if the extension selected is supported for type. 
            Can only be chosen if type is chosen.
            https://pandoc.org/MANUAL.html#extensions"
        )]
        [string[]]$OutputTypeExtension,


        # [ValidateSet(
        #     "Utf-8",
        #     "Utf-8 /w BOM",
        #     "Utf-16",
        #     "Utf-16BE",
        #     "Utf-32",
        #     "Utf-32BE",
        #     "Us-ascii",
        #     "iso-8859-1",
        #     "utf-7"
        # )]
        # [parameter(
        #     HelpMessage = "By default Pandoc uses utf8 for input and output encoding. if this is seleced, it will reencode the output to your choosing"
        # )]
        # [String]$OutputEncoding,

        [parameter(
            HelpMessage = "Will Save all images from source to this location, and will make sure that imagelinks in the resulting document "
        )]
        [String]$Mediapath,

        [switch]$TOC,

        [int]$TocDepth,

        [switch]$PreserveTabs,

        [parameter(
            HelpMessage = "Hashtable or FileInfo/Path to Yaml/Json file with metadata"
        )]
        $Metadata,
                
        [parameter(
            HelpMessage = "Arguments sent to pandoc, if not possible to be set via this"
        )]
        [String]$PandocArguments
    )
    
    begin
    {
        $Arguments = @{}

        if($PreserveTabs)
        {
            $Arguments."--preserve-tabs" = ""
        }

        if ($TOC)
        {
            $Arguments."--table-of-contents" = ""
            if($TocDepth)
            {
                $Arguments."--toc-depth" = $TocDepth
            }
        }
        elseif($TocDepth)
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

        $k = [scriptblock]::Create("Pandoc $($arg -join " ")")
        $output = $k.Invoke()
        $output
        # if($OutputEncoding)
        # {
        #     # $MyFile = Get-Content $MyPath
        #     if($OutputEncoding -eq "Utf-8")
        #     {
        #         $encoding = [System.Text.UTF8Encoding]::new($False)
        #     }
        #     elseif ($OutputEncoding -eq "Utf-8 /w BOM") {
        #         $encoding = [System.Text.UTF8Encoding]::new()
        #     }
        #     else {
        #         $encoding = [System.Text.Encoding]$OutputEncoding
        #     }
        #     [System.Text.]
        #     # $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        #     [System.IO.File]:: WriteAllLines($MyPath, $MyFile, $Utf8NoBomEncoding)
        # }
        # Start-Process pandoc -ArgumentList $Arg -Wait -NoNewWindow -Verbose # -RedirectStandardOutput proc -RedirectStandardError procerr 

        # if($procerr)
        # {
        #     $procerr|%{
        #         Write-Error $_
        #     }
        # }

        # if($proc)
        # {
        #     $proc|%{
        #         Write-Verbose $_
        #     }
        # }
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