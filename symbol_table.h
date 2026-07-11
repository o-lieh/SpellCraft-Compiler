#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#define MAX_SYMBOLS 100
#define MAX_NAME_LEN 32

typedef enum
{
    TYPE_UNKNOWN = -1,
    TYPE_MANA,
    TYPE_ELIXIR
} DataType;

typedef struct
{
    char name[MAX_NAME_LEN];
    DataType type;
    int scope;
} Symbol;

extern Symbol symbolTable[MAX_SYMBOLS];
extern int symbolCount;
extern int currentScope;

int insertSymbol(char *name, DataType type);

int lookupSymbol(char *name);

int lookupCurrentScope(char *name);

DataType getType(char *name);

void deleteScope(int scope);

void enterScope();

void exitScope();

#endif