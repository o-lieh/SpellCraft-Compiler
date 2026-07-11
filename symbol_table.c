#include <stdio.h>
#include <string.h>

#include "symbol_table.h"

Symbol symbolTable[MAX_SYMBOLS];

int symbolCount = 0;

int currentScope = 0;

int lookupCurrentScope(char *name)
{
    int i;

    for (i = symbolCount - 1; i >= 0; i--)
    {
        if (symbolTable[i].scope != currentScope)
            continue;

        if (strcmp(symbolTable[i].name, name) == 0)
            return i;
    }

    return -1;
}

int lookupSymbol(char *name)
{
    int i;

    for (i = symbolCount - 1; i >= 0; i--)
    {
        if (strcmp(symbolTable[i].name, name) == 0)
            return i;
    }

    return -1;
}

int insertSymbol(char *name, DataType type)
{
    if (lookupCurrentScope(name) != -1)
        return 0;
if (symbolCount >= MAX_SYMBOLS)
    return 0;
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].type = type;
    symbolTable[symbolCount].scope = currentScope;

    symbolCount++;

    return 1;
}

DataType getType(char *name)
{
    int index = lookupSymbol(name);

    if (index == -1)
        return TYPE_UNKNOWN;

    return symbolTable[index].type;
}

void deleteScope(int scope)
{
    while (symbolCount > 0 &&
           symbolTable[symbolCount - 1].scope == scope)
    {
        symbolCount--;
    }
}

void enterScope()
{
    currentScope++;
}

void exitScope()
{
    deleteScope(currentScope);

    currentScope--;
}