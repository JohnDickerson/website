helpers do

  def get_bib_entry(bib_key)
    bib_hash = {}
    entry = $bib[bib_key]

    # Paper or talk title, minus the {forced capitalization} required for bibtex
    bib_hash[:title] = entry.title.delete "{}"

    # Stacked list of authors separated by linebreaks
    bib_hash[:authors] = entry.author.length == 1 ? entry.author.to_s : 
      ( entry.author.to_s.gsub! ' and ', '<br/>' )
    bib_hash[:authors].gsub! 'Dickerson, John P.', '<strong>Dickerson, John P.</strong>'

    # Is this a first author publication?
    bib_hash[:first_author] = entry.author[0].last == "Dickerson"
    
    # Publication or talk year
    bib_hash[:year] = entry.type == :unpublished ? "Working" : entry.year

    # :venue will map to a booktitle or 
    bib_hash[:venue] = ""
    if not entry.booktitle.nil? then # conference
      bib_hash[:venue] += entry.booktitle.to_s
    elsif not entry.journal.nil? then # journal
      bib_hash[:venue] += entry.journal.to_s
    elsif not entry.publisher.nil? then # book
      bib_hash[:venue] += entry.publisher.to_s
    end
    
    if not entry.note.nil? then
      bib_hash[:venue] += (bib_hash[:venue].empty? ? "" : ". ") + entry.note.to_s
    end
    bib_hash[:venue].delete! "{}"

    # Absolute filepath to pdf link (MAY NOT EXIST, check elsewhere)
    bibkey_link = bib_key_to_link(bib_key)
    bib_hash[:pdfpath] = "/pubs/#{bibkey_link}.pdf"
    bib_hash[:pdflink] = "<a id=\"#{bibkey_link}\" href=\"/pubs/#{bibkey_link}.pdf\">pdf</a>"

    # Google Analytics click tracking
    bib_hash[:ga_track] = "<script type='text/javascript'>" + ga_event_tracking(bibkey_link, "/pubs/#{bibkey_link}.pdf") + "</script>"
    return bib_hash
  end


  # Takes an array of string keys into a .bib file and returns an HTML
  # list of their citations, formatted via cite_to_link
  def rep_pubs_list(bib_keys, include_links=false)
    
    bibkey_links = Array.new
    out = "<ul class='list-unstyled'>"
    out += bib_keys.uniq.map do |bib_key| 
      bibkey_link = bib_key_to_link(bib_key)
      bibkey_links << bibkey_link   # track links for GA code later
      "<li><span class='glyphicon glyphicon-chevron-right'></span>
#{cite_to_link($bib[bib_key])} " +
        ((include_links == true) ? "[<a id=\"#{bibkey_link}\" href=\"/pubs/#{bibkey_link}.pdf\">link</a>]" : "") + 
        "</li>"
    end.join
    out += "</ul>\n"

    # Include Google Analytics click tracking
    out += "<script type='text/javascript'>"
    bibkey_links.each{ |bibkey_link|
      out += ga_event_tracking(bibkey_link, "/pubs/#{bibkey_link}.pdf") + "\n"
    }
    out += "</script>"
  end

  # Google Analytics event tracking via JQuery
  def ga_event_tracking(element_name, desc)
    return "$('\##{element_name}').on('click', function() {ga('send', 'event', 'button', 'click', '#{desc}');});"
  end

  # Processes a bibtex entry into a human-readable string, and removes all {s and }s.
  def cite_to_link(bib_struct)
    base = (CiteProc.process bib_struct.to_citeproc, :style => $bib_citestyle, :format => :html).delete "{}"

    # MLA style displays "Print." after some entries, and that's dumb.  Remove it 
    base.chomp!("Print.")

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
