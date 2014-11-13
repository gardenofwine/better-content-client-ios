# BetterContent

[![CI Status](http://img.shields.io/travis/gardenofwine/BetterContent.svg?style=flat)](https://travis-ci.org/gardenofwine/BetterContent)
[![Version](https://img.shields.io/cocoapods/v/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)
[![License](https://img.shields.io/cocoapods/l/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)
[![Platform](https://img.shields.io/cocoapods/p/BetterContent.svg?style=flat)](http://cocoadocs.org/docsets/BetterContent)

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

 - Labels - only set labels that haven't changed
 - reConnect to server in increasing intervals
 - send UIVIew frame in global coordinates
 - Support iPhone/iPad horizontal in iOS7 (translate coordinates)

## Author

gardenofwine, gardenofwine@gmail.com

## License

BetterContent is available under the GPL license. See the LICENSE file for more info.
