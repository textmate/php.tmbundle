# Snippets

## Control Structures

The PHP bundle includes snippets for the common control structures, such as `if`, `while`, `switch` and `for`, and `function` and `class` definitions.
These snippets are accessible through a tab trigger for the relevant keyword.  
Some snippets are also available in the HTML scope for use in PHP templating; these will be wrapped in `<?php … ?>` blocks.

These snippets are designed to conform to the [PEAR style guide][styleguide]. To summarise:

  * Control structures have a space between the keyword and opening parenthesis and have their opening brace on the same line.
  * Functions should be called with no spaces between the function name, the opening parenthesis, and the first parameter.
  * Function and class definitions have their brace on the line following the prototype.

[styleguide]: http://www.go-pear.org/manual/en/standards.php

## PHPDoc

There are several snippets available for use when writing PHPDoc blocks. See the separate Help command for more information.

# Commands

## Completion

Standard completion for built-in function names is provided on ⎋.  
Additionally, completing a built-in function using ⌥⎋ will display a list of available options, and will expand the chosen option into a snippet for the function prototype.

## Help

There are 2 help commands, both of which work on the current word:

  * Pressing ⌃H will open a browser showing the function definition on the PHP website.
  * Pressing ⌥F1 will display a tooltip showing the function prototype and a brief description of its use.

## Misc

Dragging a .php file (from the Project Drawer or Finder, for example) into PHP source will generate an `include` for that file.  
If the environment variable `PHP_INCLUDE_PATH` is set to your PHP environment's `include_path` directive, it will be searched for the optimal path to the dropped file to include.

The command ⌥⌘↓ can be used to jump to a file included from the current document. If invoked on a line with an include/require directive, it will search for that file. Otherwise, a menu of all the included files will be displayed. The environment variable `PHP_INCLUDE_PATH` is searched for the included path as above.