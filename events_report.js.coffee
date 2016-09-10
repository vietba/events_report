# Modify from http://stackoverflow.com/a/27747641/4869393, thanks Rodolpho Brock
$.eventReport = (selector, root) ->
  s = []
  total = 0
  $(selector or '*', root).addBack().each ->
    e = $._data(this, 'events')
    if !e
      return
    tagGroup = @tagName or 'document'
    if @id
      tagGroup += '#' + @id
    if @className
      tagGroup += '.' + @className.replace(RegExp(' +', 'g'), '.')
    delegates = []
    for p of e
      r = e[p]
      h = r.length - (r.delegateCount)
      if h
        s.push [
          tagGroup
          p + ' handler' + (if h > 1 then 's' else '')
          h
        ]
        total += h
      if r.delegateCount
        q = 0
        while q < r.length
          if r[q].selector
            s.push [
              tagGroup + ' delegates'
              p + ' for ' + r[q].selector
              r.delegateCount
            ]
            total += r.delegateCount
          q++
    return
  {
    total: total
    details: s
  }

$.fn.eventReport = (selector) ->
  $.eventReport selector, this
return
