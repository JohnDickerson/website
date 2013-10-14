helpers do

  # Takes an array of string keys into a .bib file and returns an HTML
  # list of their citations, formatted via cite_to_link
  def rep_pubs_list(bib_keys, include_links=false)
    out = "<ul class='list-unstyled'>"
    
    out += bib_keys.uniq.map do |bib_key| 
      "<li><span class='glyphicon glyphicon-chevron-right'></span>
#{cite_to_link($bib[bib_key])} " +
        ((include_links == true) ? "[<a href=\"#{bib_key_to_link(bib_key)}\">link</a>]" : "") + 
        "</li>"
    end.join
    
    out += "</ul>"
  end


  def cite_to_link(bib_struct)
    CiteProc.process bib_struct.to_citeproc, :style => $bib_citestyle
  end

  # Translate a bib_key that looks like "NameYear:Title" into a URL
  def bib_key_to_link(bib_key)
    bib_key.downcase.delete(':')
  end

end
