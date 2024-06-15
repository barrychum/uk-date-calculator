# Define input and output file paths
$inputFile = "input.html"
$outputFile = "output.html"

# Read the HTML content
$htmlContent = Get-Content $inputFile -Raw

# Minify HTML (remove whitespace and comments)
$minifiedHtml = $htmlContent -replace ">\s+<", "><" -replace "<!--.*?-->", ""

# Scramble HTML attributes (for demonstration, this script only scrambles class and id attributes)
$scrambledHtml = $minifiedHtml -creplace 'class="[^"]+"', ('class="{0}"' -f ((1..9) * 1000000 | Get-Random)) -creplace 'id="[^"]+"', ('id="{0}"' -f ((1..9) * 1000000 | Get-Random))

# Reorder HTML elements (for demonstration, this script only reorders div elements)
$divs = ([regex]'<div[^>]*>[^<]*</div>').Matches($scrambledHtml) | ForEach-Object { $_.Value }
$reorderedDivs = $divs | Select-Object -SkipLast 1 | Sort-Object {Get-Random}
$finalHtml = $scrambledHtml -replace '<div[^>]*>[^<]*</div>', { $reorderedDivs[$script:divIndex++] }

# Save the final HTML to the output file
$finalHtml | Set-Content $outputFile

Write-Output "HTML minified, scrambled, and elements reordered successfully. Output saved to $outputFile"
