class Posts.UI
  constructor: ->
    @minimumTextNumber = 0
    @maximumTextNumber = 200

  renderTimeSince: ->
    $("small#post-time").each (_, obj) ->
      timesince = moment(obj.innerText).fromNow()
      this.innerHTML = timesince

  truncatePostContent: ->
    self = @
    contents = $("p#post-content-sub")

    contents.each (_, obj) ->
      text = obj.innerText
      truncated_text = self.truncate(obj.innerText)
      this.innerHTML = truncated_text

  truncate: (text) ->
    self = @
    if text.length < self.maximumTextNumber
      return text

    $.trim(text).substring(
      self.minimumTextNumber,
      self.maximumTextNumber
    ).split(" ").slice(0, -1).join(" ") + "..."
