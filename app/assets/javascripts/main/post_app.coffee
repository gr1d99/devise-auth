class Post.App
  constructor: ->
    @postUi = new Post.UI()

  truncatePostContent: (
    selector,
    minimumTextNumber,
    maximumTextNumber
  ) ->
    self = @
    self.postUi.truncatePostContent(
      selector,
      minimumTextNumber,
      maximumTextNumber
    )
