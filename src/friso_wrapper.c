#include "friso_API.h"
#include "friso.h"

#include <stdlib.h>
#include <string.h>

static friso_t friso = NULL;
static friso_task_t task = NULL;

void fr_free()
{
  if (!task)
  {
    return;
  }

  friso_free_task(task);
  task = NULL;
}

void fr_seg(const char* str)
{
  if (!friso)
  {
    printf("!!!!fwlekfwe");
    friso = friso_new_from_ifile("/friso.ini");
  }

  task = friso_new_task();
  friso_set_text(task, str);
}

string fr_next()
{
  if (!task)
  {
    return NULL;
  }

  friso_hits_t hits = friso_next(friso, friso->mode, task);
  if (hits == NULL)
  {
    return NULL;
  }

  printf("%s\n", task->hits->word);
  return task->hits->word;
}

