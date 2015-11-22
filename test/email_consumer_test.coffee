ConsumerObject = require './test_helper'
EmailConsumer = require './../lib/email_consumer'

describe 'EmailConsumer', ->

  messageConsumer = memo().is -> new ConsumerObject()
  emailjsserver = memo().is -> {send: ->}
  emailConsumer = memo().is -> new EmailConsumer(emailjsserver(), messageConsumer())

  describe '#start', ->
    beforeEach ->
      sinon.spy(messageConsumer(), "on")
      emailConsumer().start()

    afterEach ->
      messageConsumer().on.restore()

    it 'starts consuming messages', ->
      expect(messageConsumer().on).to.be.calledOnce

  context 'when listening for messages', ->
    beforeEach ->
      emailConsumer().start()

    context 'when receiving a message', ->
      context 'and valid message', ->
        messageValue = memo().is -> { from: "stenver1010@gmail.com", to: "stenver1010@gmail.com" }
        beforeEach ->
          sinon.spy(emailjsserver(), "send")
          messageConsumer().emit('message', {value: JSON.stringify(messageValue()) } )

        it "sends and email with the message", ->
          expect(emailjsserver().send).to.be.calledOnce

      context 'and invalid message', ->
        messageValue = memo().is -> { }

        it "sends and email with the message", ->
          emailserverspy = sinon.spy(emailjsserver(), "send")
          messageConsumer().emit('message', {value: JSON.stringify(messageValue()) } )
          expect(emailserverspy.called).to.equal(false)


