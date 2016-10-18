#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <inttypes.h>

#define PINSEL0 (*((uint32_t volatile *)0xE002C000))
#define IO0DIR  (*((uint32_t volatile *)0xE0028008))
#define IO0SET  (*((uint32_t volatile *)0xE0028004))
#define IO0CLR  (*((uint32_t volatile *)0xE002800C))

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
  PINSEL0 &= ~((1 << 22) | (1 << 23));
  IO0DIR |= (1 << 11);
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
    IO0CLR |= (1 << 11);
  }
  else
  {
    LED_ON = 1;
    IO0SET |= (1 << 11);
  }
}
