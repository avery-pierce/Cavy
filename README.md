# Cavy
Cavy is a [Lemmy](https://join.lemmy.ml) client for iOS, written in Swift

Cavy aims to be competitive with professionally made apps like Reddit in functionality, look-and-feel, and accessibility. The app should be easy to use, and feel right at home on iOS. The experience should be friendly not just to Lemmy power users, but also users new to Lemmy and the broader fediverse.

## State of the project

Cavy is still in it's exploratory development phase, which means the app may change drastically before release. As of today, Cavy does not support logging in – it is read-only. However, you may find value in being able to browse instances and save favorite communities.

At a high-level, these are the items that need to be complete before it makes sense to release on the app store:

* Log in
* App icon
* Onboarding flow educating new users about Lemmy and federation (federated social networks are still a new concept to a lot of people)
* Accessibility audit

For more detail, please see the projects tab of the github repository.

## Project Virtues

* Put the user first: 
  * No analytics or other data is collected
  * Cache data where possible, avoid redundant fetches
* Eliminate friction for contributors:
  * Project should be able to build and run with the latest production release of Xcode
  * Neither Cocoapods nor Carthage should be required
  * Avoid using SwiftPM dependencies, if possible

## Contributing

Before contributing, please review the project's [Code of Conduct](./CODE_OF_CONDUCT.md). Violating the code of conduct may result in a permanent ban.

There are a few ways you can contribute:

* Developer Track:
  * Find an issue you can solve, and open a PR to have your code merged
  * Review open PRs and provide feedback
* QA Track:
  * Discover bugs, and open issues in github
  * Ensure bugs are reproducible, and provide reproduction steps in the issue if they aren't present. (screenshots and recordings are incredibly helpful)
  * Identify duplicate issues, and close them

All contributors are invited to add themselves to `CONTRIBUTORS.md`.
