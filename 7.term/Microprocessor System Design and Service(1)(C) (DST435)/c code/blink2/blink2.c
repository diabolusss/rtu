#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <inttypes.h>

#define PINSEL9 (*((uint32_t volatile *)0xE002C024))
#define FIO4DIR (*((uint32_t volatile *)0x3FFFC080))
#define FIO4SET (*((uint32_t volatile *)0x3FFFC098))
#define FIO4CLR (*((uint32_t volatile *)0x3FFFC09C))

void ledInit(void);
void blink();
void toggle_led(void);

int main(int argc,char **argv)
{
  printf("\n");
  ledInit();
  blink();
  exit(EXIT_SUCCESS);
}

void ledInit(void)
{
  PINSEL9 &= ~((1 << 30) | (1 << 31));
  FIO4DIR |= (1 << 31);
}

void blink()
{
  int i;
  for(i=0;i<121;i++)
  {
    toggle_led();
    usleep(100000);
  }
}

void toggle_led(void)
{
  static int LED_ON = 1;
  if(LED_ON)
  {
    LED_ON = 0;
    FIO4CLR |= (1 << 31);
  }
  else
  {
    LED_ON = 1;
    FIO4SET |= (1 << 31);
  }
}


