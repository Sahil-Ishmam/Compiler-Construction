#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"

char *typename[] = {"UNDEF_TYPE", "INT_TYPE", "CHAR_TYPE", "DOUBLE_TYPE"};
list_t *head = NULL;

void insert(char *name, int type, int lineno)
{
    if (search(name) != NULL)
    {
        printf("In line no %d, Same variable %s is declared more than once.\n",
               lineno, name);
        return;
    }
    list_t *node = (list_t *)malloc(sizeof(list_t));
    strcpy(node->st_name, name);
    node->st_type = type;
    node->next = head;
    head = node;
    printf("In line no %d, Inserting %s with type %s in symbol table.\n",
           lineno, name, typename[type]);
}

list_t *search(char *name)
{
    list_t *temp = head;
    while (temp != NULL)
    {
        if (strcmp(temp->st_name, name) == 0)
            return temp;
        temp = temp->next;
    }
    return NULL;
}

int is_declared(char *name)
{
    return (search(name) != NULL);
}

int get_type(char *name)
{
    list_t *sym = search(name);
    if (sym != NULL)
        return sym->st_type;
    return UNDEF_TYPE;
}

int type_check(char *name1, char *name2, int lineno)
{
    int t1 = get_type(name1);
    int t2 = get_type(name2);

    if (t1 == UNDEF_TYPE)
    {
        printf("In line no %d, ID %s is not declared.\n", lineno, name1);
    }
    if (t2 == UNDEF_TYPE)
    {
        printf("In line no %d, ID %s is not declared.\n", lineno, name2);
    }
    if (t1 != t2 && t1 != UNDEF_TYPE && t2 != UNDEF_TYPE)
    {
        printf("In line no %d, Data type %s is not matched with Data type %s.\n",
               lineno, typename[t1], typename[t2]);
        return 0;
    }
    return 1;
}

void print_symtab()
{
    list_t *temp = head;
    printf("\n%-15s %-15s\n", "Variable", "Type");
    printf("-----------------------------\n");
    while (temp != NULL)
    {
        printf("%-15s %-15s\n", temp->st_name, typename[temp->st_type]);
        temp = temp->next;
    }
}
