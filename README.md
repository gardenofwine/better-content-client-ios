# BetterContent

__Work in progress__

[![CI Status](http://img.shields.io/travis/gardenofwine/BetterContent.svg?style=flat)](https://travis-ci.org/gardenofwine/BetterContent)
[![Version](https://img.shields.io/cocoapods/v/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)
[![License](https://img.shields.io/cocoapods/l/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)
[![Platform](https://img.shields.io/cocoapods/p/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)

![](https://github.com/gardenofwine/better-content-server/blob/master/BetterContentDemo.gif)

## Server counterpart
https://github.com/gardenofwine/better-content-server

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BetterContent is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "BetterContent"

## Configuration

BetterContent will try to access a websocket server on ws://localhost:5000 by default. In order to customize the url, Edit the `BTCConstants.h` file.

<sub>_(Since Bettercontent is a Development only pod, I did not wish to pollute any common assets such as `app.plist` in order to edit the URL property.)_</sub>

## TODO

 - reConnect to server in increasing intervals
 - Support iPhone/iPad horizontal in iOS7 (translate coordinates)

# Copyright
Copyright (c) 2014-2015 Benny Weingarten-Gabbay.

MIT License. See (LICENSE)[LICENSE] for details.
