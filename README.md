# SpellCraft Compiler

A simple educational compiler developed for a **Compiler Design** course using **Flex** and **Bison**.

SpellCraft is a small programming language with a fantasy-inspired syntax. The compiler performs lexical analysis, syntax analysis, symbol table management, scope handling, and basic semantic analysis.

---

## Features

* Lexical analysis using **Flex**
* Syntax analysis using **Bison**
* Symbol table implementation
* Nested scope management
* Variable declaration and assignment
* Integer (`mana`) and floating-point (`elixir`) data types
* Arithmetic expressions
* Conditional statements
* Semantic error detection
* Type compatibility checking

---

## Language Overview

### Data Types

```text
mana
elixir
```

### Variable Declaration

```text
mana $health~
elixir $damage~

mana $score => 100~
elixir $power => 25.5~
```

### Assignment

```text
$score => 150~
```

### Arithmetic Expressions

```text
mana $a => 10~
mana $b => 5~
mana $c => ($a + $b) * 2~
```

### Conditional Statements

```text
cast_if ($a == $b)
begin_spell
    mana $x => 1~
end_spell

cast_else
begin_spell
    mana $x => 0~
end_spell
```

---

## Identifier Format

Identifiers must begin with `$` followed by one or more English letters or digits.

```regex
\$[a-zA-Z0-9]+
```

Examples:

```text
$hp
$magic99
$123
```

---

## Supported Operators

| Operator | Description         |
| -------- | ------------------- |
| `=>`     | Assignment          |
| `==`     | Equality comparison |
| `+`      | Addition            |
| `-`      | Subtraction         |
| `*`      | Multiplication      |
| `/`      | Division            |

Every statement must end with:

```text
~
```

---

## Project Structure

```text
SpellCraft/
│
├── lexer.l
├── parser.y
├── symbol_table.h
├── symbol_table.c
├── main.c
│
├── parser.tab.c
├── parser.tab.h
├── lex.yy.c
│
└── spellcraft.exe
```

---

## Building the Project

Generate the parser:

```bash
bison -d parser.y
```

Generate the lexer:

```bash
flex lexer.l
```

Compile the project:

```bash
gcc parser.tab.c lex.yy.c symbol_table.c main.c -o spellcraft.exe
```

---

## Running

```bash
spellcraft.exe < input.txt
```

---

## Semantic Checks

The compiler performs several semantic checks, including:

* Duplicate variable declarations within the same scope
* Undefined variable usage
* Scope management
* Type compatibility during assignments

Example warnings and errors:

```text
Error: Undefined spell $x.
```

```text
Error: Spell $x is already conjured!
```

```text
Warning: Alchemy error! Pours elixir into a mana vessel.
```

---

## Scope Rules

* Each `begin_spell ... end_spell` block creates a new scope.
* Variables declared inside a block are removed when leaving the block.
* Shadowing is allowed.
* Redeclaration within the same scope is not allowed.

---

## Technologies

* C
* Flex 2.6.x
* GNU Bison
* GCC

---

## Author

by olieh, thank you. 

