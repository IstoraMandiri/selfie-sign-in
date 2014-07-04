resize =  (w, h, store, fileObj, readStream, writeStream) ->
  # scale and resize the image using gm streams
  # XXX Make this more eloquent (using thumb method?)
  # really we should find a better way to convert to JPEG
  fileObj.extension('jpeg', {store:store})
  fileObj.type('image/jpeg', {store:store})
  gm(readStream, fileObj.name())
  # sometimes images come with the wrong orientation
  .autoOrient()
  .quality(80)
  .resize(w, h)
  # remove exif data
  .noProfile()
  .stream('JPEG')
  .pipe(writeStream)

@selfieSignIn =
  # initialize a collectionFS file store for image uploads
  # create a 'thumbs' and a 'large' copy of each uploaded image
  collection : new FS.Collection 'selfieSignIn',
    # only accept images
    filter:
      allow: {contentType:['image/*']}
    # XXX DRY this out
    stores: [
      new FS.Store.GridFS 'thumbs',
        transformWrite: (fileObj, readStream, writeStream) ->
          resize 150, 150, 'thumbs', fileObj, readStream, writeStream # make this nicer
      ,
      new FS.Store.GridFS 'large',
        transformWrite: (fileObj, readStream, writeStream) ->
          resize 768, 768, 'large', fileObj, readStream, writeStream
    ]

if Meteor.isServer
  # Make the CollectionFS store available to the public
  # XXX consider whether to do this automatically
  Meteor.publish 'selfieSignIn', -> selfieSignIn.collection.find()

  # Custom login helper for meteor acocunts
  # XXX Make this not conflicting with accounts-testing package somehow44
  Accounts.registerLoginHandler (loginRequest) ->
    return unless loginRequest.username and loginRequest.profile

    if Meteor.users.findOne {username: loginRequest.username}
      # Only allow poeple to create NEW acconts
      throw new Meteor.error "This selfie already exists"
    else
      # populate user data on new account creation
      userId = Accounts.insertUserDoc {},
        # the username is the ID of the collectionFS file (the selfie)
        # the name is stored in the profile object
        username: loginRequest.username
        profile: loginRequest.profile
        created_at: new Date()

      return {userId : userId}


if Meteor.isClient
  # XXX consider whether to do this automatically
  Meteor.subscribe 'selfieSignIn'

  selfieSignIn.signIn = (selfieId, profile) ->
    # not sure exactly how this works
    # should be target to specific login request method
    # XXX Make this not conflicting with accounts-testing package somehow44
    Accounts.callLoginMethod
      methodArguments: [{username: selfieId, profile: profile}]

