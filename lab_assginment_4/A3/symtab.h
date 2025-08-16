#ifndef SYMTAB_H
#define SYMTAB_H

#define UNDEF_TYPE 0
#define INT_TYPE 1
#define CHAR_TYPE 2
#define DOUBLE_TYPE 3

extern char *typename[];

typedef struct list_t
{
    char st_name[40];
    int st_type;
    struct list_t *next;
} list_t;

void insert(char *name, int type, int lineno);
list_t *search(char *name);
int is_declared(char *name);
int get_type(char *name);
int type_check(char *name1, char *name2, int lineno);
void print_symtab();

#endif
