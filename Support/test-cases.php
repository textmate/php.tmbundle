<?php

//
// Namespaces & Classes
//
namespace blah;
namespace one_two;
namespace blah\one\two;

use foo\bar;

use \foo\bar;

use \foo\bar,
    \bar\foo,
    blah_foo\foo,
    one\more_time\forKicks;

namespace one\more 
{
    use \foo\bar;
}

class Foo 
{
}

class Foo extends Bar
{
}

class Foo extends foo\Bar
{
}

class Foo implements Bar
{
}

class Foo implements foo\Bar
{
}

class Foo extends foo\Bar implements foo\Bar
{
}

abstract class Foo;
abstract class Foo {}

abstract class Foo extends Bar;
abstract class Foo extends Bar {}

abstract class Foo extends foo\Bar;
abstract class Foo extends foo\Bar {}

interface Foo
{
}

interface Foo extends Bar
{
}

interface Foo extends foo\blah\Bar 
{
}

// =============
// = Functions =
// =============
function test()
function test($foo, $foo = 1, &$foo = array(), &$foo = array(1, "2", "3", 4))
function test(array $foo = array(1, "2", "3", 4), array &$foo = array(), array $foo = null, array $foo = invalid)
function test(stdClass $foo)
function test(stdClass $foo = null)
function &test(stdClass $foo = invalid)

$blah = function (stdClass $foo = invalid, array $blah = array()) {
    
};

$blah = function (stdClass $foo = invalid, array $blah) use ($foo, $bar) {
    $test = 'test';
};

$blah();
$blah(1, 2, 3);
blah(1, 2, 3);

$blah = new Foo();
$blah = new Foo;
$blah = new \blah\Foo();
$blah = new blah\Foo();
$blah = new $foo();
$blah = new $foo;
$blah = new blah\$Foo();

// ========================
// = String interpolation =
// ========================
'$foo'
'\''
'\\'
"1\1111"
"1\x111"
"$foo"
"$foo[bar]"
"$foo[0]"
"$foo[$bar]"
"$foo->bar"
"$foo->$foo"
"{$foo->$bar}"
"{$foo->bar}"
"{$foo->bar[0]->baz}"
"{$foo->bar(12, $foo)}"
"{$foo(12, $foo)}"

$foo = $foo->{'foo' . 'bar'};

// Heredoc
$foo = <<<BLAH
Blah blah $foo blah {$foo->bar} 
Stuff goes here
BLAH;

// Nowdoc (no interpolation should occur here)
$foo = <<<'BLAH'
Blah blah $foo blah {$foo->bar} 
Stuff goes here
BLAH;

namespace foo\bar;

// =======
// = SQL =
// =======
'SELECT * from foo WHERE bar = \'foo \\ ' . $foo . 'sadas';
'SELECT * from foo WHERE bar = "foo" asdas' . $foo . '" asdasd';


"SELECT * from foo WHERE bar = 'asd $foo $foo->bar {$foo->bar[12]} asda'  'unclosed string";
"SELECT * from foo WHERE bar = \"dsa$foo\" \"unclosed string"
'SELECT * from foo WHERE bar = "unclosed string';

'SELECT * from foo WHERE bar = "foo \" ' . $foo . ' bar" AND foo = 1';

// Comments

'SELECT * FROM # foo bar \' asdassdsaas';
'SELECT * FROM -- foo bar \' asdassdsaas';
"SELECT * FROM # foo bar \" asdassdsaas";
"SELECT * FROM -- foo bar \" asdassdsaas";
?>