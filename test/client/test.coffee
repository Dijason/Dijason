Session.set 'reasonNums', 1

Template.newEle.rendered = ->
  HELPERS.updateReasonNum()

HELPERS = 
  sendDataByAjax: (url, dataToSend) ->
    Meteor.http.post url,{data: dataToSend},(err, res)->
      if err then console.log err.reason else $('.show-res:first').text(res.content)
  updateReasonNum: ->
    $('.reason-num').each (i)->
      $(this).text(i+1)
  init: ->
    window.onload = ->
      Meteor.call 'query',(err, res)->
        if err then console.log err.reason else HELPERS.recover res
  recover: (res)->
    for i in [1...res.length]
      newItem = Meteor.render Template.newEle      
      $('.add-ele-example .items').append newItem
    $('.items input[name="reason"]').each (i)->
      $(this).val(res[i])
    HELPERS.updateReasonNum()
###
    window.onbeforeunload = ->
      res = []
      $('input[name="reason"]').each (i)->
        res.push $(this).val()
      HELPERS.setCookie 'reason',res.join(" ") , 1
      "Warning"
    window.onunload = ->
      false
  setCookie: (cname, val, expire)->
    exdate = new Date()
    exdate.setTime exdate.getTime()+expire*1000*3600*24
    expire = if expire then ";expires="+exdate.toGMTString() else ""
    document.cookie = cname + "=" + escape(val) + expire
  getCookie: (cname) ->
    if document.cookie.length > 0 
      cstart = document.cookie.indexOf(cname + "=")
      if cstart != -1
        cstart = cstart + cname.length + 1
        cend = document.cookie.indexOf ";", cstart
        if cend == -1 then cend = document.cookie.length
        return unescape document.cookie.substring(cstart, cend)
    ""
  deleteCookie: (cname) ->
    if document.cookie < 1
      return 
    HELPERS.setCookie cname, "",1
window.onload = ->
  res = HELPERS.getCookie 'reason'
  if res then HELPERS.recover res.split(' ')
  HELPERS.deleteCookie 'reason'
###

HELPERS.init()        
Template.newEle.events 
  'click .delete-btn': (e) ->
    $(e.target.parentNode.parentNode).remove()
    HELPERS.updateReasonNum()
Template.addNewEle.events 
  'click .add-btn': (e) ->
    newItem = Meteor.render Template.newEle
    $('.add-ele-example .items').append newItem
    HELPERS.updateReasonNum()
  'click .submit': (e) ->
    e.preventDefault()
    vals = []
    $('input[name="reason"]').each (i)->
      if $(this).val() then vals.push $(this).val() 
    Meteor.call 'insertReasons', vals, (err)->
      if err then console.log err.reason else console.log 'success'
    false
