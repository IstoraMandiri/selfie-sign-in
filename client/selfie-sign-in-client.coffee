UI.registerHelper 'getSelfie' : (user) -> console.log 'getting selfie for', user

Template.selfie_sign_in.events
  'change input.selfie-upload' : (e) ->
    selfieSignIn.collection.insert e.target.files[0], (err, fileObj) ->
      Session.set 'selfieSignInUpload', fileObj._id

  'click button.selfie-submit' : (e) ->
    name = $(e.currentTarget).parent().find('input.selfie-name').val()
    if name
      profile = {name:name}
      console.log 'creating user', profile
      selfieSignIn.signIn Session.get('selfieSignInUpload'), profile, (err,res) ->
        console.log err, res
        console.log 'logged in'

Template.selfie_sign_in.helpers
  'tempSelfie' : -> selfieSignIn.collection.findOne Session.get 'selfieSignInUpload'
  'loggedIn' : -> Meteor.user()

