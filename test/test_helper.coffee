global.sinon = require 'sinon'
global.chai = require 'chai'
global.expect = chai.expect
global.memo = require 'memo-is'

sinonChai = require 'sinon-chai'
chai.use(sinonChai)

class ConsumerObject
  constructor: ->
    @callbacks = {}
  on: (message, cb) ->
    @callbacks[message] = cb
  emit: (message, object) ->
    @callbacks[message](object)

module.exports = ConsumerObject
