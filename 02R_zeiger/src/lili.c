#include <stdlib.h>
#include <stdio.h>
#include "lili.h"

element_t *head = NULL;

//implement necessary functions here

//adds element to the linkedlist
unsigned int* insert_element(unsigned int value)
{
    element_t *new_element = malloc(sizeof(element_t));
    //if there is no place to save the data print ERROR
    if (new_element == NULL)
    {
        perror("ERROR");
        return NULL;
    }
    new_element->data = value;
    new_element->next = NULL;

    //if the linkedlist is empty add the element as head
    if (head == NULL)
    {
        head = new_element;
    }
    //if linkedlist not empty
    else
    {
        element_t *temp = head;
        //goes through linkedlist till the last element
        while(temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = new_element;
    }
    return &new_element->data;
}

//delete the oldest element from linkedlist
unsigned int remove_element(void)
{
    //if linkedlist empty
    if (head == NULL)
    {
        printf("WARNING: nothing to remove, lili is empty\n");
        return 0;
    }
    element_t *temp = head;
    head = temp->next;
    unsigned int deleted_value = temp->data;
    free(temp);
    return deleted_value;
}

//prints linkedlist
void print_lili(void)
{
    element_t *temp = head;
    //if linkedlist empty
    if (temp == NULL) {
        printf("print_lili: \n");
    }
    else
    {
        printf("print_lili: ");
        //goes through linkedlist till the last element
        while(temp != NULL)
        {
            printf("%d, ",temp->data);
            temp = temp->next;
        }
        printf("\n");
    }
}
