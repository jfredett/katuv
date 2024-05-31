# 31-MAY-2024

## 1524

Resurrection is a tough game, but ten years isn't that long in the ground; time to see what kind of
necromancy I can pull.

I started `katuv` as a project to build a hammer for which I had no nails. I got most of the way
there, then realized the nails weren't appearing and so I lost steam and left it in a partial state.
In the intervening decade, some bitrot has definitely set in; the `mutant` gem now has a different
licensing scheme, and doesn't seem to work anymore; the `crystalline` gem is way out of date, also
due to bitrot, but I think I should be able to get things mostly fixed up and running again, now
that I have something more like a nail to use this with.

In particular, I want to build up some modelling tools for infrastructure that can ultimately be
'compiled' down to a Nix (or suitable replacement a la Lix or Aux... however you spell the thing)
config for a number of machines. I have a big hybrid cloud/on-prem infrastructure I call a 'homelab'
that I would like to generate models for, and I think `katuv` is the right tool to define that DSL
so that I can also build up tools to interact with it.

This log is a new thing I've been doing for my projects, since I tend to flip between them
frequently, and need a better way to retain context across projects over time.
