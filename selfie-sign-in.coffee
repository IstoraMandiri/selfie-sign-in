resize =  (w, h, fileObj, readStream, writeStream) ->
  fileObj.extension('jpeg')
  fileObj.type('image/jpeg')
  gm(readStream, fileObj.name())
  .autoOrient()
  .quality(90)
  .resize(w, h)
  .noProfile()
  .stream('JPEG')
  .pipe(writeStream)

@selfieSignIn =
  # collectionFS file store for image uploads
  collection : new FS.Collection 'selfieSignIn',
    filter:
      allow: {contentType:['image/*']}
    stores: [
      new FS.Store.GridFS 'thumbs',
        transformWrite: (fileObj, readStream, writeStream) ->
          resize 150, 150, fileObj, readStream, writeStream # make this nicer
      ,
      new FS.Store.GridFS 'large',
        transformWrite: (fileObj, readStream, writeStream) ->
          resize 768, 768, fileObj, readStream, writeStream
    ]

if Meteor.isServer
  Meteor.publish 'selfieSignIn', -> selfieSignIn.collection.find()

  # selfie sign in
  Accounts.registerLoginHandler (loginRequest) ->

    return unless loginRequest.username and loginRequest.profile

    user = Meteor.users.findOne
      username: loginRequest.username

    unless user
      userId = Accounts.insertUserDoc {},
        username: loginRequest.username
        profile: loginRequest.profile

      return {userId : userId}

if Meteor.isClient
  Meteor.subscribe 'selfieSignIn'

  selfieSignIn.signIn = (selfieId, profile, callback) ->
    Accounts.callLoginMethod
      methodArguments: [{username: selfieId, profile: profile}],
      userCallback: callback

