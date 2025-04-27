
# Rapport technique  
### Jeu 2‑D coopératif en OCaml – Projet “Fire & Water”  
*(binôme : anthang / Lynn159 )*

## 1 | introduction de projet 

Nous avons développé, en quatre semaines, un **plate‑former coopératif** inspiré de _Fireboy & Watergirl_.  
Contraintes : OCaml ≥ 5.1, aucune lib’ de jeu complète ; seul **SDL2** sert au rendu et aux entrées.  
Les avatars **Fire** (rouge) et **Water** (bleu) doivent sauter, actionner des portails, collecter leurs diamants et quitter le niveau ensemble.

Objectifs pédagogiques :

* mettre en œuvre une **architecture Entity‑Component‑System (ECS)** en OCaml ;
* écrire un **moteur 2‑D minimal** : boucle temps‑réel, gravité, collisions.

---

## 2 | Organisation et répartition du travail  

| Auteur Git | Commits | Tâches dominantes |
|------------|---------|-------------------|
| **anthang** | 40 / 42 | `physics.ml`, `collision.ml`, `input.ml`, trois niveaux, tests, CI, documentation |
| **Lynn159** | 2 / 42 | Squelette initial (ECS / SDL), assets PNG, validation gameplay |

---

## 3 | Structure du dépôt (`src/`)  

```
components/   -- Position, Velocity, Box, Mass, …
core/         -- boucle SDL, entrée clavier, Vector.ml, Rect.ml
systems/      -- Physics, Collision, Render, Input
levels/       -- level01.ml, level02.ml
```

_Pipeline d’une frame_ : **Input → Physics → Collision → Gameplay → Render**

---

## 4 | Physique et collisions  

### 4.1 Hypothèses  

* Espace 2‑D, AABB pour toutes les entités.  
* Gravité `g = 900 px·s⁻²` (sur les masses finies).  
* Pas fixe `dt = 1 / 60 s`.  
* Décor : masse ∞.

### 4.2 Intégration (`systems/physics.ml`)  

```ocaml
let a  = Vector.mult (1. /. m) forces in   (* a = F / m *)
let v' = Vector.add v (Vector.mult dt a) in
let p' = Vector.add p (Vector.mult dt v') in
e#velocity#set v';        (* stocke la nouvelle vitesse *)
e#position#set p';        (* stocke la nouvelle position *)
e#forces#set Vector.zero  (* reset forces pour la prochaine frame *)
```

### 4.3 Détection & réponse (`systems/collision.ml`)  

```ocaml
if Rect.has_origin pdiff rdiff then (
  let pn = Rect.penetration_vector pdiff rdiff in   (* plus petite sortie *)
  (* séparation proportionnelle aux vitesses *)
  e1#position#set (Vector.add p1 (Vector.mult n1 pn));
  e2#position#set (Vector.sub p2 (Vector.mult n2 pn));
  (* notification via resolver *)
  e1#resolve#get (Vector.normalize pn) (e2 :> tagged);
  e2#resolve#get (Vector.normalize pn) (e1 :> tagged)
)
```

* **Différence de Minkowski** (`Rect.mdiff`) : convertit la collision AABB en test « l’origine est‑elle dans le rectangle ? ».  
* **`penetration_vector`** : calcule la **translation minimale** pour sortir du contact.  
* Les résolveurs d’entités (joueur, portail, diamant…) appliquent l’effet de jeu (rebond, téléportation, gain de score).

---

## 5 | Scripts de niveaux  

Les niveaux sont écrits en OCaml pur.  
Exemple *level02.ml* : deux portails bleus **A ↔ B** :

```ocaml
Portail.portail (395, 185, Texture.blue, 420, 185);
Portail.portail (420, 185, Texture.blue, 395, 185);
```

Le bug d’offset a été corrigé en utilisant le centre de la hitbox.

---