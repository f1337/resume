---
layout: post
title: BDD Cheat Sheet
date: 2012-01-15 16:48:05.000000000 -08:00
categories: technology essays
tags: testing BDD
excerpt: ''
---
### Epic

A large or complex feature that should be broken into several user stories:

* Two-Factor Authentication
* Password Expiration
* Account Suspension

### Story

A use-case describing a desired behavior and its business value:

	AS A [person/role who will benefit],
	I WANT [some product or service to behave in a particular manner],
	SO THAT [some benefit or value is provided].

### Scenario

A story's acceptance criterion, to be implemented as an *executable test*,
described using [Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin):

	GIVEN [some initial context],
	WHEN [an event occurs],
	THEN [ensure some outcomes].
