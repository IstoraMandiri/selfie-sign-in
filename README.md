# Selfie Sign In

# WORK IN PROGRESS

A selfie-based login method for Meteor.

Users are are able to login by uploading an image, which becomes their avatar for the duration of the session. If they are using a mobile device, they are prompted to take a picture using their camera, and are encouraged to take a selfie.

## Quickstart

Install using meteorite

```
$ mrt add selfie-sign-in
```

Add the login template to your app.

```
{{> selfie_sign_in}}
```
This step is optional unless you want to write your own UI. 

You might not have graphicsmagick installed, which is required to convert the uploaded images. On OS X, you can install it using [Homebrew](http://brew.sh/).


```
 $ brew install graphicsmagick
```

## Details

This package allows users to create accounts within your meteor app. They can't re-login to a previously-created account, so other than having having low persistence, this package offers little in the way of security.

Submitted images are uploaded, stored and proceed by the wonderful [CollectionFS](https://github.com/CollectionFS/Meteor-CollectionFS) package. Uploaded selfies are converted using graphicsmagick to thumbnails and higher resolution images in JPEG format.

For ease transportation, selfie-sign-in uses MongoDB's gridFS file store by default. Currently this isn't supported but can be solved easily with a pull request or issue.

## API 

```
{{#each user}}
  <img src="{{selfie.url}}"/>
  <img src="{{user.selfie.url filestore='large"/>
{{/each}}
```

## Write your own UI

Finally, the image id is stored with the user that has just logged in, and is made accessible using CollectionFS's helpers

```
<img src="{{user.selfie.url}}"/>
```


## How it works (TBC)

IF the username is required, then obviously use the FSimage id as the username.

Otherwise, what's the point?



## Features/Components

* A login system with GUI
* An API for accessing/viewing the image on a user (use CFS getFile)
* Mobile API
* Works out of the box with zero config, configurable if needed


## Other Packages Used

* CollectionFS (and some of it's siblings)


