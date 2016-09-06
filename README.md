# Decks Template ([Demo](http://borisschapira.github.io/decks-template/))

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

```bash
bundle install --path vendor/bundle
```

# Usage

## Preparation

- Use the `_cursus` folder to manage your training programs (rename `_cursus_sample` into `_cursus` to see an example)
- Use the `_decks` folder to manage your decks (rename `_decks_sample` into `_decks` to see an example)
- Use the `_slides` folder to manage your slides (rename `_slides_sample` into `_slides` to see an example)

Training programs, decks and slides are ordered by the name of the file that represent them.

## Build and vizualize

The command

```
bundle exec rake
```

will verify that your contribution are ready and build the website to be consulted at the address: <http://localhost:4000/decks-template/>

## Other commands

### Before the build

```bash
bundle exec rake prebuild:test:cursus   # Test if the Front-Matter of cursus is YAML-valid
bundle exec rake prebuild:test:decks    # Test if the Front-Matter of decks is YAML-valid
bundle exec rake prebuild:test:doctor   # Executes the jekyll doctor
bundle exec rake prebuild:test:slides   # Test if the Front-Matter of slides is YAML-valid
```

### Building

```bash
bundle exec rake build:clean                # Clean Jekyll build
bundle exec rake build:generate             # Generate for deployment (but do not deploy)
bundle exec rake build:preview              # Preview on local machine (server with --auto)
bundle exec rake postbuild:test:alt         # Test the generated website alt messages on images
bundle exec rake postbuild:test:externals   # Test the generated website external links
bundle exec rake postbuild:test:kiss        # Test if generated website is valid (do not test external links)
bundle exec rake prebuild:test:cursus       # Test if the Front-Matter of cursus is YAML-valid
bundle exec rake prebuild:test:decks        # Test if the Front-Matter of decks is YAML-valid
bundle exec rake prebuild:test:doctor       # Executes the jekyll doctor
bundle exec rake prebuild:test:slides       # Test if the Front-Matter of slides is YAML-valid
```

### After the build

```bash
bundle exec rake postbuild:test:alt         # Test the generated website alt messages on images
bundle exec rake postbuild:test:externals   # Test the generated website external links
bundle exec rake postbuild:test:kiss        # Test if generated website is valid (do not test external links)
```

# Explaining the magic

## Cursus, decks and slides

Cursus, decks and slides are managed through Jekyll Collections. In order to establish relations between cursus and decks, and decks and slides, I created the [slideMetaData](./_plugins/slideMetaData.rb) plugin. The relations are based on name convention so make sure that you always name your cursus and decks with the same name.

## Full-markdown slides

[Work-in-progress](https://talk.jekyllrb.com/t/referencing-an-asset-inside-a-collection-item-used-on-multiple-pages/2326)
