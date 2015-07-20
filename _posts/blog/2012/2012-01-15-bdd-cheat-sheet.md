---
layout: post
title: BDD Cheat Sheet
date: 2012-01-15 16:48:05.000000000 -08:00
categories: technology essays
tags: testing BDD
---
### Epic

A large or complex user story that should be broken into several smaller stories:

* Two-Factor Authentication
* Password Expiration
* Account Suspension

### Story

A feature written as:

	AS A [person/role who will benefit],
	I WANT [some feature],
	SO THAT [some benefit or value is provided].

### Scenario

A story's acceptance criterion, to be implemented as an *executable test*, and written as:

	GIVEN [some initial context],
	WHEN [an event occurs],
	THEN [ensure some outcomes].
