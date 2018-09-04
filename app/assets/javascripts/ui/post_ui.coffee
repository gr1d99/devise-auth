class Post.UI
  truncatePostContent: (
    selector,
    minimumTextNumber,
    maximumTextNumber
  ) ->
    self = @
    contents = $(selector)

    contents.each (_, obj) ->
      text = obj.innerText
      truncated_text = self.truncate(
        obj.innerText,
        minimumTextNumber,
        maximumTextNumber
      )
      this.innerHTML = truncated_text

  truncate: (
    text,
    minimumTextNumber,
    maximumTextNumber
  ) ->
    self = @
    if text.length < maximumTextNumber
      return text

    $.trim(text).substring(
      minimumTextNumber,
      maximumTextNumber
    ).split(" ").slice(0, -1).join(" ") + "..."
