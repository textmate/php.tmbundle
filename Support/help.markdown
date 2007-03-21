# Snippets

## Control Structures

The PHP bundle includes snippets for the common control structures, such as `if`, `while`, `switch` and `for`, as well as `function` and `class` definitions.
These snippets are accessible through a tab trigger for the relevant keyword.  
Some snippets are also available in the HTML scope for use in templating using PHP; these will be wrapped in `<?php … ?>` blocks.

These snippets are designed to conform to the [PEAR style guide][]. To summarise:

  * Control structures have a space between the keyword and opening parenthesis and have their opening brace on the same line.
  * Functions should be called with no spaces between the function name, the opening parenthesis, and the first parameter.
  * Function and class definitions have their brace on the line following the prototype.

[PEAR style guide]: http://www.go-pear.org/manual/en/standards.php

## PHPDoc

There are several snippets available for use when writing PHPDoc blocks. See the separate Help command for more information.

# Commands

## Completion

Standard completion for built-in function names is provided by pressing the ⎋ key.  
Additionally, completing a built-in function using ⌥⎋ will display a list of available options, and will expand the chosen option into a snippet for the function prototype.  
When ⎋ completion is invoked inside of a string following an `include`/`require`, the filename will be completed instead. The environment variable `PHP_INCLUDE_PATH` is used to look for matching files - see "Include Path Configuration" below for details on this.

## Function Reference

There are 2 help commands, both of which work on the current word:

  * Pressing ⌃H will open a browser showing the function definition on the PHP website.
  * Pressing ⌥F1 will display a tooltip showing the function prototype and a brief description of its use.

## Drag Commands

Dragging a .php file (from the Project Drawer or Finder, for example) into PHP source will generate an `include` for that file.  
If the environment variable `PHP_INCLUDE_PATH` is set to your PHP environment's `include_path` directive, it will be searched for the optimal path to the dropped file to include.

## Project Navigation

The command ⇧⌘D can be used to jump to a file included from the current document. If invoked on a line with an `include`/`require` directive, it will search for that file. Otherwise, a menu of all the included files will be displayed. The environment variable `PHP_INCLUDE_PATH` is searched for the included path as above.

# Setup

## Include Path Configuration

The environment variable `PHP_INCLUDE_PATH` is used for the 2 commands above. This variable should contain a colon-separated list of directories to scan for PHP include files (as in your PHP configuration). The correct value for this variable can be found either by checking the output of phpInfo() or printing the result of get\_include_path(). The best way to set this up is as a [Project Dependent Variable](?project_dependent_variables) – make sure nothing is selected in the project drawer and then press the ⓘ icon to configure these.

See section 9, "Environment variables" in the [TextMate help](?environment_variables) for more information on setting environment variables.

## Adding PHP Error Linkbacks

Using the snippet `phperr⇥` you can add some JavaScript to your HTML templates which will scan the page for PHP errors and add links to open the relevant file and line in TextMate. If you already have a project open with a folder reference which includes the file, then TextMate will open the file as a tab in that project.