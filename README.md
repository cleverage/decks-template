# Decks-template

Ce projet permet de produire, à partir de sources en Markdown, un site statique prêt à l'hébergement, contenant l'ensemble des présentations voulues. Ces présentations sont exportables en PDF.

## Prérequis

* [Git](http://git-scm.com/)
* [NodeJS](http://nodejs.org/) (l'utilisation de [nvm](https://github.com/creationix/nvm) est fortement conseillée)
* [Ruby](http://www.ruby-lang.org) (l'utilisation de [rvm](https://rvm.io/rvm/install) est également conseillée)
* [Compass](http://compass-style.org/install/)

## Installation et utilisation

Pour installer l'ensemble des dépendances du projet :

```bash
npm install;
bower install;
```

## Écriture

Pour lancer le site en local avec un jeu de slides de tests, renommez `slides_samples` en `slides` puis exécutez :

```bash
$ npm run serve
```

Le site est alors disponible sur <http://localhost:9000> et se met à jour au fil des contributions. Pour uniquement compiler sans prévisualiser, exécuter `npm run build`.

### Contribution et organisation des fichiers

À la racine du dossier `slides`, vous devez placer :

* un dossier par présentation à compiler ;
* un fichier `list.json` décrivant ces présentations.

Dans chaque présentation, vous pouvez organiser vos slides sous la forme de fichiers MarkDown indépendants, à plat ou dans un dossier représentant un défilement vertical. Un fichier `list.json`, facultatif, vous permet de réorganiser vos slides ou d'en sélectionner une sous-partie si nécessaire.
