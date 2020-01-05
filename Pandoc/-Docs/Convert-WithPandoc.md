---
external help file: Pandoc-help.xml
Module Name: Pandoc
online version:
schema: 2.0.0
---

# Convert-WithPandoc

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
Convert-WithPandoc [-inputobject] <Object> [[-InputType] <Object>] [[-InputTypeExtension] <Object>]
 [[-InputGrouping] <String[]>] [[-Outputtype] <String>] [[-Mediapath] <String>] [-TOC] [[-TocDepth] <Int32>]
 [-PreserveTabs] [[-Metadata] <Object>] [[-Arguments] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Arguments
Arguments sent to pandoc, if not possible to be set via this

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputGrouping
{{ Fill InputGrouping Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputType
{{ Fill InputType Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: commonmark, creole, docbook, docx, dokuwiki, epub, fb2, gfm, haddock, html, ipynb, jats, jira, json, latex, man, markdown, markdown_github, markdown_mmd, markdown_phpextra, markdown_strict, mediawiki, muse, native, odt, opml, org, rst, t2t, textile, tikiwiki, twiki, vimwiki

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputTypeExtension
{{ Fill InputTypeExtension Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mediapath
{{ Fill Mediapath Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Metadata
Hashtable or FileInfo/Path to Yaml/Json file with metadata

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Outputtype
{{ Fill Outputtype Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: asciidoc, asciidoctor, beamer, commonmark, context, docbook, docbook4, docbook5, docx, dokuwiki, dzslides, epub, epub2, epub3, fb2, gfm, haddock, html, html4, html5, icml, ipynb, jats, jira, json, latex, man, markdown, markdown_github, markdown_mmd, markdown_phpextra, markdown_strict, mediawiki, ms, muse, native, odt, opendocument, opml, org, pdf, plain, pptx, revealjs, rst, rtf, s5, slideous, slidy, tei, texinfo, textile, xwiki, zimwiki

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreserveTabs
{{ Fill PreserveTabs Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TOC
{{ Fill TOC Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TocDepth
{{ Fill TocDepth Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inputobject
Fileinfo,Directoryinfo,File Fullname,URL

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
