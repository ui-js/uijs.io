---
permalink: /blog/part-1-introduction/
title: A web app framework from scratch
layout: single
sidebar:
  - nav: blog-sidebar
---

<style>
h1 {
  font-size: 5rem;
  line-height: .9;
  text-transform: uppercase;
  letter-spacing: -4px;
  font-weight: 700;
  color: #303047;
}

h1 .eyebrow {
  display: block;
  font-size: 1rem;
  letter-spacing: 0;
  font-weight: 600;
  color: #aaa;
}
</style>

<h1><span class='eyebrow'>Part 1</span>Building a Modern Web App Framework</h1>

In this series we're going to build a modern web app framework from scratch.

_"Oh no! Who needs another framework!?!"_, I hear you think. Fair enough.

But what better way to learn something than by building it? We will understand
what it takes to build a framework and the tradeoffs involved. This will help us
to make better use of existing frameworks, while having fun building our own.

This will also be an opportunity to put in practice **architectural thinking**:
how to design from the start a complex piece of software by considering some
initial requirements and anticipating future needs.

## Prerequisites

Since our goal is to build an app framework for the web platform, we'll assume
you already have some familiarity with Javascript and HTML.

- **Javascript**. We'll be using the most recent version of Javascript,
  [ES2020](https://262.ecma-international.org/11.0/), including features such as
  [spread/rest operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax)
  (`...`),
  [optional chaining](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining)
  (`?.`),
  [nullish coalescing](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing_operator)
  (`??`),
  [promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise),
  and
  [`async/await`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function).
  We'll also use Typescript, but these sections will be optional and we'll
  introduce what you need to know as we go.

- **HTML, CSS, DOM**. If you've authored a web page in a text editor, you
  probably know enough to follow along.

## What about my favorite framework?

One of the beauty of the web platform is its fantastic diversity.

Other platforms tend to have a single (or two) frameworks designed by the
platform vendors.

But in the web ecosystem, there's a new framework becoming popular every week!
This has encouraged a lot of experimentation and using different solutions to
solve the same problems.

We'll discuss the fundamental problems being solved by web app framework and
possible solutions. We'll also occasionally discuss in side notes how some the
concepts introduced apply to specific frameworks, such as React, Vue, Svelte or
Angular.

## I'm not a web developer!

If you have a different background, such as UIKit, SwiftUI or Android, you
probably won't have too many difficulties following along and you'll see that
many of the topics discussed here apply as well. A modern web app is not
fundamentally different from a mobile or desktop app.

## What's the difference between a framework and a library?

The difference between a library and a framework is summarized in the
[The Hollywood Principle](https://en.wikipedia.org/wiki/Inversion_of_control):
**"Don't call us, we'll call you."** [1]

In a nutshell: a library provides a set of entry points (functions, classes,
etc...) that the client app calls to perform certain functions. The client is
responsible for orchestrating these calls.

On the other hand, a client provides to a framework a set of callbacks that the
framework calls to respond to various events. The framework defines the flow of
communication between software components.

A framework will usually require less boilerplate code to be written and will
more strongly suggest a specific way to organize your code. In some cases you
may find this to be an unwelcome constraint, but on the other hand it also
provides useful guidelines to ensure the architecture of your web app is sound
from the start. This is particularly important when building a complex app as
getting started on the right footing will avoid having to do painful
re-architecting later on as the app grows in complexity.

## Do I even need a framework?

It depends on the complexity of what you build. For a blog, probably not. For an
interactive web app with a complex state that needs to be persisted across user
visits, an app framework will probably be useful.

Every web app starts very simple and at the beginning a framework may seem like
unnecessary complexity. However, as your app grows, with features added, and
people joining your team, a framework will help you scale.

## Application Architecture

Before discussing what we need from a framework, let's talk about how we're
going to structure our web app.

A web app is [typically](https://en.wikipedia.org/wiki/Multitier_architecture)
made of a **frontend** that runs in the browser and a **backend** that runs on
remote servers.

The backend has one or more services that can serve requests and that stores
data in a database of some kind.

With a static web site, a blog for example, the backend is also responsible for
generating the content that is displayed in the browser: it sends directly to
the browser HTML/CSS that is ready to be displayed.

But we'll look at apps where the presentation (and interactivity) is happening
in the browser. Those apps are sometimes called SPA (Single Page Apps) because
the servers send a single page, and that page is responsible for orchestrating
what is presented to the user and how to react to it. Furthermore, that single
"page" can actually displays what appears to the user as multiple "pages", but
we'll discuss that in more detail when we talk about "routing".

<figure>
  <img src='/assets/blog/01-02.png' style='max-height: 500px'>
  <figcaption>Web App Architecture</figcaption>
</figure>

Our framework will focus on the front and will help manage the presentation,
business logic and data model of our app.

- **Presentation:** the user interface, the set of on-screen components that the
  user interacts with. Its purpose is to display information to and collect
  information from the user. This will be represented with some HTML, CSS and
  JavaScript. This will be a collection of standardized components (buttons,
  menus, calendar widget, etc...) organized in ways that are specific to the
  application.
- **Business Logic:** This is the heart of the application. It builds and
  updates the presentation layer and handle the user input. It orchestrates the
  communication between the presentation and data model layers.
- **Data model:** It manages and handles the persistent storage of the data. The
  Data Model is ignorant of the Presentation layer. For example, a data model
  could be the content of a shopping cart: a list of item, each with a quantity.
  This could be represented in the Presentation layer as a list of item, or as a
  simple icon with a counter of the items in the shopping cart.

Model-View-Controller, Model-View-Binder or Model-View-ViewModel

## What about backends?

We'll focus on front-end solutions, that is code that runs in the browser.

Most web app will include a server-side component, and there are server-side web
app frameworks as well but that won't be the focus of our discussion.

## Developer Ergonomics

A web app framework is a tool for developers. **Developer ergonomics** is
something that's useful to think about whenever you are building an API that is
intended to be used by other developers.

There's no reason why an API shouldn't be easy to learn and easy to use. Those
two goals can be in conflict, so we'll pay careful attention on how to balance
them.

**Simplicity**

If you can minimize the number of new concepts that need to be mastered, your
API will be easier to learn. We'll assume that developers using our framework
are familiar with the concepts of the web platform, including events and
asynchronous operations. We will also assume that they are comfortable with the
dynamic and polymorphic nature of JavaScript.

On the other hand we will not assume an understanding of **Object-Oriented
Programming** or **Functional Programming** techniques. While our target
audience may well be familiar with these concepts, we don't have to make use of
every single areas of knowledge our audience may have unless we can directly
benefit from it.

> "Programs are meant to be read by humans and only incidentally for computers
> to execute." – Donald Knuth

**Consistency**

Learning a new API, or becoming proficient at using one, can be made
tremendously easier if it is internally consistent, and consistent with other
APIs the developer will already be familiar with. That consistency can manifest
itself in the naming conventions for entry points and data structures and the
idioms used (for example: an asynchronous function always return a `Promise`).
By being consistent it becomes easier for the developer to "guess" how something
is supposed to be used.

**Brevity**

A small API surface of expressive entry points is easier to learn. It is more
difficult to find "the right entrypoint" in a large set. We'll endeavor to keep
a minimal set of entry points, a dozen or so, and we'll make them flexible
enough that they can be used for all the use cases.

> The utility of a language as a tool of thought increases with the range of
> topics it can treat, but decreases with the amount of vocabulary and the
> complexity of grammatical rules which the user must keep in mind. Economy of
> notation is therefore important. – Kenneth Iverson

**Clarity**

Code is written once and read many times. It helps if the name of entry points
clearly reflects what they are doing.

> As the saying goes: "There are only two hard things in Computer Science: cache
> invalidation, naming things and off-by-one errors".

**Correctness**

## Benefits of a framework?

Let's explore some of the common problems you will encounter as you try to build
a large, complex, web app and how frameworks can help tackle them.

As in many software projects, a key challenge of building a web app is to manage
complexity. In the case of a web app this complexity takes the form of the
relationships between UI components and between UI components and the
application state (data model).

As new UI components get added and as the data model get more complicated, the
possible connections increase exponentially.

Managing complexity. Tracking connections is exponentially hard.

First, it's useful to divide your app between **state** and **ui**.

The **state** of your app is the set of data

We will build an app in SwiftUI to see how Apple’s new framework approaches
solving these problems.

A complex app:

- State that needs to be persisted.
- Using API request to load data.
- Multiple screens that need to communicate with each other.

// https://jsonplaceholder.typicode.com/guide/

- Scalability. Could write everything by hand, but then you have to keep track
  of dependencies, in particular when the state of your app changes, which UI
  components need to be updated. Famous Facebook notification bug. Basically
  created React to squash that bug.

- A good framework can do the bookkeeping for you, apply some optimization
  techniques, so you can focus on more abstract concepts.

- Example of a naive approach: modify a state property, re-render the
  component(s) that depends on it. But what if other properties dependend on
  this property, and had other components dependending on _these_ properties? Or
  maybe the same component depending on the original property and those indirect
  properties. Are you going to render more than you need to?

## Features

Principles?

Sinkhole anti-pattern where data/requests are just passed-through.

Brevity/Clarity: How much code do you have to read to understand something?

Goals:

- counter
- todo

Comparison with other frameworks

- tersness / brevity
- clarity
- consistency /
- modularity - separation of concern
- Don't Repeat Yourself (DRY)
- Single Source of Truth (SSOT)

- Avoid Premature Abstraction. YAGNI (You Aren’t Gonna Need It)/KISS. Avoid
  premature abstraction. Software systems work best when they are kept simple.
  Avoiding unnecessary complexity will make your system more robust, easier to
  understand, easier to reason about, and easier to extend.

- Principle Of Least Astonishment

- [Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter): don't talk to
  strangers. a given object should assume as little as possible about the
  structure or properties of anything else (including its subcomponents), in
  accordance with the principle of "information hiding". (use only one dot)

- SOLID

  - Single Responsibility Principle.
  - Open for Extension / Closed for Modifications
  - Liskov Substitution Principle: subclasses respect theit parent's contract
  - Interface Segregation Principle: should not depend on interface you don't
    use
  - Dependency Inversion Principle: higher-level modules should not depend on
    lower level modules, but on abstract interfaces

- Dependency injection: meant to preserve abstraction. But in a large app can
  lead to a proliferation of "manager"-like classes that need to have instances
  propagated down. Better to lift the dependencies and abstract them as data in
  the app state.

# Future Posts

- **Rendering**
- **Messaging**
- **State Management**
- **Routing**

[1] [Hollywood's Law](https://www.digibarn.com/friends/curbow/star/XDEPaper.pdf)

> "A monad is a monoid in the category of endofunctors"
