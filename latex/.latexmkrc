#!/usr/bin/env perl

$latex = 'platex -synctex=1 -halt-on-error -file-line-error %O %S';
$max_repeat = 5;
$bibtex = 'pbibtex %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';
$makeindex = 'mendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$pdf_mode = 3;
$pvc_view_file_via_temporary = 0;
