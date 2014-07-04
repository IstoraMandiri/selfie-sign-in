getSelfie = (_id) -> selfieSignIn.collection.findOne({_id:_id})?.url()

UI.registerHelper 'getSelfie', -> getSelfie @username

Template.selfie_sign_in.events
  'change input.selfie-upload' : (e) ->
    selfieSignIn.collection.insert e.target.files[0], (err, fileObj) ->
      Session.set 'selfieSignInUpload', fileObj._id

  'click button.selfie-submit' : (e) ->
    name = $(e.currentTarget).parent().find('input.selfie-name').val()
    if name
      profile = {name:name}
      selfieSignIn.signIn Session.get('selfieSignInUpload'), profile

Template.selfie_sign_in.helpers
  'tempSelfie' : -> getSelfie Session.get('selfieSignInUpload')
  'loggedIn' : -> Meteor.user()

