validator = require('validator')
R = require 'ramda'

class Email
  constructor: ({@from, @to, @cc, @subject, @text})->

  isValid: ->
    @_fromValid() && @_toValid() && @_ccValid() && @_subjectValid && @_textValid()

  _fromValid: ->
    validator.isEmail(@from, allow_display_name: true)

  _toValid: ->
    @_receiversValid(@to) if @to

  _ccValid: ->
    if @cc then  @_receiversValid(@cc) else true

  _subjectValid: ->
    true

  _textValid: ->
    true

  _receiversValid: (receivers) ->
    receivers = R.split(',', receivers)
    if receivers.length > 1
      R.any(@_isValidEmail)(receivers)
    else
      @_isValidEmail(receivers)

  _isValidEmail: (receiver) ->
    validator.isEmail(receiver, allow_display_name: true)

module.exports = Email
