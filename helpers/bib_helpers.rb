helpers do

  # Takes an array of string keys into a .bib file and returns an HTML
  # list of their citations, formatted via cite_to_link
  def rep_pubs_list(bib_keys, include_links=false)
    out = "<ul class='list-unstyled'>"
    
    out += bib_keys.uniq.map do |bib_key| 
      "<li><span class='glyphicon glyphicon-chevron-right'></span>
#{cite_to_link($bib[bib_key])} " +
        ((include_links == true) ? "[<a href=\"/pubs/#{bib_key_to_link(bib_key)}.pdf\">link</a>]" : "") + 
        "</li>"
    end.join
    
    out += "</ul>"
  end

  # Processes a bibtex entry into a human-readable string, and removes all {s and }s.
  def cite_to_link(bib_struct)
    base = (CiteProc.process bib_struct.to_citeproc, :style => $bib_citestyle, :format => :html).delete "{}"
    # Can't figure out how to display note field in bibtex, so force it in
    if not bib_struct[:note].nil? then
      base += " " + (bib_struct[:note].delete "{}")
    end
    return base
  end

  # Translate a bib_key that looks like "NameYear:Title" into a URL
  def bib_key_to_link(bib_key)
    bib_key.downcase.delete(':')
  end

end
