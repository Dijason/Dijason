Meteor.methods
  insertReasons: (vals) ->
    Reasons.insert
      reason: vals
  query: ->
    res = Reasons.find({}).fetch()
    res


