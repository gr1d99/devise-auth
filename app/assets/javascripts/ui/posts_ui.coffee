class Posts.UI
  renderTimeSince: ->
    $("small#post-time").each (_, obj) ->
      created_at = obj.innerText
      return obj if isNaN(Date.parse(created_at))
      timesince = moment(created_at).fromNow()
      this.innerHTML = timesince
