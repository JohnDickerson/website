helpers do

  # Takes an array of string keys into a .bib file and returns an HTML
  # list of their citations, formatted via cite_to_link
  def rep_pubs_list(bib_keys)
    out = "<ul class='list-unstyled'>"
    
    out += bib_keys.uniq.map do |bib_key| 
      "<li>
#{cite_to_link($bib[bib_key])}
</li>"
    end.join

    out += "</ul>"
  end


  def cite_to_link(bib_struct)
    CiteProc.process bib_struct.to_citeproc, :style => :apa
  end

end
