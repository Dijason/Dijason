Session.set 'reasonNums', 1
###
Template.addNewEle.reasonNums = ->
  if Session.get('reasonNums') >= 1 then [1..Session.get('reasonNums')] else 0
###
Template.newEle.events 
  'click .delete-item': (e) ->
    Template.newEle.foo()
    #Session.set 'reasonNums', Session.get('reasonNums')-1

Template.newEle.foo = ->
  this.data

newEleNode = null
Template.addNewEle.created = ->
  console.log this
  newEleNode = $('.new-element:first').clone(true)
  console.log newEleNode
  this

Template.addNewEle.events 
  'click .add-item': (e) ->
    frag = Meteor.render ->
      Template.newEle
    console.log frag
#    $('.add-ele-example:first').append(frag)
    #console.log newEleNode.clone(true)
    #$('.add-ele-example:first').append(newEleNode.clone(true))
    #Session.set 'reasonNums', Session.get('reasonNums')+1
  'click .delete-item': (e) ->
    console.log e.target.parentNode
    $(e.target.parentNode).remove()
  
    
