module ApplicationHelper

  # change the default link renderer for will_paginate and add global options
  def paginate(collection , options = {})
    #options = options.merge defaults
    options[:renderer] = BootstrapPagination::Rails
    will_paginate collection, options
  end

  def admin?
    current_user.admin != nil
  end

  def song_text song
    info = song.link
    return "" unless info
    host = URI.parse(info).host rescue nil
    return "" unless host
    parts = host.split(".")
    parts.delete_at(0) if parts.length == 3
    parts.join(".")
  end

  def break_braces(string)
    parts = string.split("(")
    return string if parts.length == 1
    "#{parts.first} <br/> (#{parts.last}".html_safe
  end

  def shorten( max , string)
    return "" unless string
    return string if string.length < max
    words = string.split(" ")
    ret = ""
    until words.empty?
      ret += get_line(max , words)
      ret += "<br/>"
    end
    ret.html_safe
  end
  private

  def get_line(max , words)
    line = ""
    while(!words.empty?)
      return line if (line.length + words.first.length) > max
      line += " #{words.shift}"
    end
    line
  end
end
