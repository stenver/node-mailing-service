require './test_helper'
Email = require './../lib/models/email'

describe 'Email', ->
  to = memo().is ->
  from = memo().is ->
  cc = memo().is ->
  subject = memo().is ->
  text = memo().is ->

  parameters = memo().is -> {to: to(), from: from(), cc: cc(), subject: subject(), text: text()}
  email = memo().is -> new Email(parameters())

  describe '#isValid', ->
    context 'with valid to and from parameters', ->
      to.is -> "stenver1010@gmail.com"
      from.is -> "stenver1010@gmail.com"

      it 'returns true', ->
        expect(email().isValid()).to.equal(true)

      context 'with display name on to and from', ->
        to.is -> "stenver <stenver1010@gmail.com>"
        from.is -> "stenver <stenver1010@gmail.com>"

        it 'returns true', ->
          expect(email().isValid()).to.equal(true)

      context 'with multiple receivers', ->
        to.is -> "stenver <stenver1010@gmail.com>, example <example@gmail.com>"

        it 'returns true', ->
          expect(email().isValid()).to.equal(true)


    context 'with invalid parameters', ->
      to.is -> "stenver1010"
      from.is -> "stenver1010"

      it 'returns false', ->
        expect(email().isValid()).to.equal(false)


