# eventually this should be redudant using EJSON, and calling `url` directly
getSelfie = (_id) -> selfieSignIn.collection.findOne({_id:_id})?.url()

# should be unecessary with `url` method
UI.registerHelper 'getSelfie', -> getSelfie @username

Template.selfie_sign_in.events
  'change input.selfie-upload' : (e) ->
    selfieSignIn.collection.insert e.target.files[0], (err, fileObj) ->
      # eventually this should be EJSON of the fileObj itself, rather than the ID
      Session.set 'selfieSignInUpload', fileObj._id

  'click button.selfie-submit' : (e) ->
    name = $(e.currentTarget).parent().find('input.selfie-name').val()
    if name # XX make this 'validation' more verbose
      profile = {name:name}
      # potentially add some other details into the profile?
      selfieSignIn.signIn Session.get('selfieSignInUpload'), profile

Template.selfie_sign_in.helpers
  'uploadedSelfie' : -> getSelfie Session.get('selfieSignInUpload')
  'loggedIn' : -> Meteor.user()

