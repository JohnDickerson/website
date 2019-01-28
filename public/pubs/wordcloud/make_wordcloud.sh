#!/bin/bash

# Grabs a list of words from the Abstracts of each of the .pdfs in
# the publications directory.  Adapted from:
# http://skipperkongen.dk/2011/09/07/creating-a-word-cloud-from-pdf-documents/

# Switches to an environment where 'tr' and 'grep' accept byte sequences
# instead of text
export LC_CTYPE=C

# The final wordcloud text will be stored here
FINAL=wordcloud.txt

# Temporary files
BASE=_wordcloud_
ALLh=${BASE}all.html
ALLt=${BASE}all.txt
CLEANt=${BASE}clean.txt
WORDSt=${BASE}words.txt
FREQSt=${BASE}freqs.txt
TOPWORDSt=${BASE}topwords.txt

# Find all .pdf files, rip pdf to html, ignore images (-i)
touch ${ALLh}
find ../ -name "*.pdf" | xargs -n1 pdftohtml -stdout -i >> ${ALLh}

# Remove HTML tags via plaintext dump
touch ${ALLt}
lynx -dump ${ALLh} >> ${ALLt}

# Remove non-printable characters
tr -dc '[:print:]' < ${ALLt} > ${CLEANt}

# Delete "stopwords" (smaller words we don't care about) [do once only]
#curl -o stopwords.txt http://skipperkongen.dk/files/english-stopwords-short.txt

# Clean words up (lowercase, no stopwords, etc) for the final wordcloud
cat ${CLEANt} | \
sed 's/[^a-zA-Z]/ /g' | \
tr '[:upper:]' '[:lower:]' | \
tr ' ' '
' | \
sed '/^$/d' | \
sed '/^[a-z]$/d' | \
grep -v -w -f stopwords.txt | \
sort > ${WORDSt}

# Get a list of the top K common words
uniq -c < ${WORDSt} | sort -r -n > ${FREQSt}
head -n150 < ${FREQSt} | tr -s ' ' | cut -f3 -d' ' > ${TOPWORDSt}

# Filter so we only have repeats for the top words, delete lesser words
rm -f ${FINAL}
cat ${WORDSt} | grep -w -f ${TOPWORDSt} > ${FINAL}

# Cleanup all the temporary files
rm -f ${ALLh} ${ALLt} ${CLEANt} ${WORDSt} ${FREQSt} ${TOPWORDSt}

# Go to Wordle or wherever and input wordcloud.txt!
# Also good: http://timc.idv.tw/wordcloud/
# Raw text: https://raw.github.com/JohnDickerson/website/master/public/pubs/wordcloud/wordcloud.txt
