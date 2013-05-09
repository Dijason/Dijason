Session.set 'reasonNums', 1

Template.addNewEle.reasonNums = ->
  if Session.get('reasonNums') >= 1 then [1..Session.get('reasonNums')] else 0

Template.newEle.created = ->
  Template.newEle.num = this.data

HELPERS = 
  saveVal: (e, todel) ->
    todel = parseInt(todel)-1
    store = []
    for i in [0..Session.get('reasonNums')]
      if i != todel
        tmpv = $($('input[name="reason"]').get(i)).val()
        if tmpv then store.push tmpv 
    setTimeout ->
      for v,i in store
        $($('input[name="reason"]').get(i)).val(v)
    ,20
  sendDataByAjax: (url, dataToSend) ->
    Meteor.http.post url,{data: dataToSend},(err, res)->
      if err then console.log err.reason else $('.show-res:first').text(res.content)

Template.newEle.events 
  'click .delete-btn': (e) ->
    todel = $('.reason-num:first',e.target.parentNode.parentNode).text()
    HELPERS.saveVal e, todel
    Session.set 'reasonNums', Session.get('reasonNums')-1

Template.addNewEle.events 
  'click .add-btn': (e) ->
    HELPERS.saveVal e, 0
    Session.set 'reasonNums', Session.get('reasonNums')+1
  'click .submit': (e) ->
    e.preventDefault()
    vals = []
    $('input[name="reason"]').each (i)->
      if $(this).val() then vals.push $(this).val() 
    Meteor.call 'insertReasons', vals, (err)->
      if err then console.log err.reason else console.log 'success'
    false
  
    
