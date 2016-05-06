# Decks Template

Decks Template is an example of how you can use Jekyll to manage different training programs, each of them composer of several decks of slides, organized by chapters.

It makes a heavy use of Jekyll's collections:

- training programs, or as I call them "cursus", are a collection
- decks inside of each programs, are also a collection
- slides inside the decks are also a collection

In order to know which slide goes in which deck goes in which cursus, you will need to always name them the same way. That's all. _Convention over configuration_.

# Prerequisites

* [Git](http://git-scm.com/)
* Ruby and [Bundler](http://bundler.io/)

# Installation

```
bundle install --path vendor/bundle
```

# Usage



Rename `slides_samples` to `slides` and there you go with a :

```
npm run serve;
```

Enjoy !
