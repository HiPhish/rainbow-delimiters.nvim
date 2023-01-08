.. default-role:: code

- Adjust queries for all languages to the use new captures
- Allow setting the strategy per file type


#######################
 Plans for this plugin
#######################

The goal of the fork is to make the plugin more extensible and hackable.  As
little as possible should be hard-coded, users should be able to override as
much as possible.  Users should be able to write their own logic outside the
plugin and not have to patch the plugin itself.

Highlighting strategies
   By default the entire buffer is highlighted, but maybe users want to only
   highlight a portion.  A strategy implements how to to perform highlighting.
   The strategy protocol requires that a strategy table contains a number of
   entries which map to functions with specific signatures.

Custom queries (or predicates)
   What parts do we want to highlight?  Queries allow users to specify if they
   want to highlight e.g. parentheses, entire words (e.g. HTML tags) or maybe
   something else entirely.  This replaces the extended mode.

Custom colours
   Highlighting should use Vim colour groups.  We can specify our own names and
   let users define (or link) them on their own.

Documentation
   A proper manual, not the README.
