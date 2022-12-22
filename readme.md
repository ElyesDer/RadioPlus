
# RadioPlus
built with SwiftUI, using the MVVM design pattern and repository pattern. The app communicates with a backend server to fetch data, and has unit tests for the network layer.

## Note
Server response doesn't contain any media / images / covers. So a `randomColor()` and `randomImage()` have been used for each entity rendered.
_I hope Im not wrong about the missing medias._

## Features
- Asynchronous fetch from server
- Decomposed UI layout generated based on server response. 'First In first rendered'
- Search engine based on local data

## Architecture
Built using the MVVM design pattern, which helps to separate the UI code from the business logic. 
The repository pattern is used to abstract the data access layer.

## Unit Tests
Unit tests have been written for the network layer to ensure reliable communication with the backend server. 
These tests can be run by navigating to the Tests folder in Xcode and running the RadioPlusTests target.

## Requirements
iOS 14.0+
Xcode 12+

## Overview
- MVVM, Repository Design Pattern
- Network layer built in TDD
- Uses Reactive programming with Combine / SwiftUI
- Uses Async / Await for networking.
- Support Dark/ Light 
- Uses Github Actions CI for merges

## Depencencies
zero

## Installation
Clone the repository, build and run

