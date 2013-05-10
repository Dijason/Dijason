Meteor.methods
  insertReasons: (vals) ->
    Reasons.insert
      reason: vals
    res = Reasons.find({}).fetch()
    console.log 
  query: ->
    res = Reasons.find({}).fetch()
    res.slice(-1)[0].reason


