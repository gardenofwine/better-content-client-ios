[![CI Status](http://img.shields.io/travis/gardenofwine/BetterContent.svg?style=flat)](https://travis-ci.org/gardenofwine/BetterContent)
[![Version](https://img.shields.io/cocoapods/v/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)
[![License](https://img.shields.io/cocoapods/l/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)
[![Platform](https://img.shields.io/cocoapods/p/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)

# BetterContent iOS pod

A dead simple plugin to allow runtime editing of the app's content.

![](https://github.com/gardenofwine/better-content-server/blob/master/BetterContentDemo.gif)

## Installation

BetterContent is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "BetterContent"

## Usage

Run your application, and open http://bettercontent.herokuapp.com. By default, the pod communicates with this server. You can change the server url by editing `BTCConstants.h` in the pod source files.

## Server counterpart
You can run your own BetterContent server by cloning
https://github.com/gardenofwine/better-content-server

## TODO

 - reConnect to server in increasing intervals
 - Support iPhone/iPad horizontal in iOS7 (translate coordinates)

# Copyright
Copyright (c) 2014-2015 Benny Weingarten-Gabbay.

MIT License. See [LICENSE](LICENSE) for details.
