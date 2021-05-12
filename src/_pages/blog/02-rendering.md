---
permalink: /blog/part-2-rendering/
title: Rendering
sidebar:
  nav: blog-sidebar
layout: single
---

# Part 2 – Rendering

## Optimizing rendering

As a web app, we'll have to render a lot compared to a static page.

Browser rendering: parse/paint/style/layout/display cycle.

## Rendering markup

Let's start simple: to render content, simplify specify the HTML markup for it.

```js
const gCountdown = 60;
function renderApp(countdown) {
  return `<h1>Countdown</h1><h2>${countdown}</h2>`;
}

setTimeout(() => {
  document.body.innerHTML = renderApp(gCountdown--);
}, 1000);
```

Works well, but require browse to parse martup and rebuild the DOM each time.

## Rendering DOM element

A more efficient way is to programatically render the HTML element:

```js
const gCountdown = 60;
function renderApp(countdown) {
    return [
        let el = document.createElement('h1');
        el.innerText = 'Countdown';
        el = document.createElement('h2');
        el.innerText = Number(countDown).toString();
    ]
}

function render(el, content) {
    el.innerHTML = '';
    content.forEach((x) => el.append(x));
}

setTimeout(() => {
    render(document.body, renderApp(gCountdown--));
}, 1000);
```

## Rendering with JSX

## Rendering with a virtual DOM
