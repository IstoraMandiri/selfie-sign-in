# Selfie Sign In

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

You might not have graphicsmagick installed, which is required to confer the uploaded images.

```
 $ brew install graphicsmagick
```

## Details

This package allows users to *create* accounts. They can't re-login to a previously-created accounts. As such, this login method offers zero persistence and zero security (other than a zero persistence, which in most cases is pretty secure).

Submitted images are uploaded, stored and proceed by the wonderful collectionFS package. For ease of implementation and transportation, selfie-sign-in uses MongoDB's gridFS file store. Selfies are converted using graphicsmagick to thumbnails and higher resolution images.

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


