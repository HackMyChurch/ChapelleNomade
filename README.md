# Chapelle Nomade (HackMyChurch)
Projet « Chapelle nomade »

---

## Dispositif

Ce dispositif est situé dans une chapelle nomade, dans un espace clos. Le `crucistick` est un contrôleur à une main qui permet à l'utilisateur de switcher entre plusieurs modes affichés à l'écran, comme la *contemplation* ou la *contempl'action*. Ainsi, l'utilisateur peut vivre une expérience individuelle.

Techniquement, l'utilisateur exploite le `crucistick` pour interagir avec un script Processing qui propose deux modes : l'un joue une vidéo en boucle (contemplation), l'autre fait défiler des grandes images dans lesquelles l'utilisateur peut se déplacer avec le `crucistick` (contempl'action).

## Fonctionnement

Le dispositif prototype est constitué de :

* Un écran
* Un ordinateur
* Un Makey Makey
* Une mini chapelle en carton et en bois

## Électronique

Le Makey Makey est très pratique pour simuler des touches sans passer par un nouveau réseau Arduino à créer de toute pièce. Ainsi, le Processing est attentif aux 4 touches fléchées du clavier et à la touche `Espace`. Le Makey Makey est branché à l'ordinateur faisant tourner le Processing.

![Schema Makey Makey](Makey Makey/Schema Makey Makey.png)
