class Posts.App
  constructor: ->
    @postsUi = new Posts.UI()

  start: =>
    self = @
    self.postsUi.renderTimeSince()
