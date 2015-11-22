Email = require './models/email'
EmailSender = require './email_sender'

class EmailConsumer
  constructor: (@emailjsserver, @messageConsumer) ->

  start: ->
    console.log("Consuming messages on node-email")
    @messageConsumer.on "message", @_consumeMessage

  _consumeMessage: (message) =>
    console.log("Received message", message)

    email = @_parseMessage(message.value)
    if email && email.isValid()
      @emailjsserver.send email, (err, message) ->
        console.log(err || message)
    else
      console.log("Error: Email not valid")

  _parseMessage: (message)->
    try
      new Email(JSON.parse(message))
    catch err
      console.log(err)

module.exports = EmailConsumer
