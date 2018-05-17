ENTRY(inicio)
MEMORY
{
  FLASH (rx)      : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 128K
  MEMORY_B1 (rx)  : ORIGIN = 0x60000000, LENGTH = 0K
  CCMRAM (rw)     : ORIGIN = 0x10000000, LENGTH = 64K
}
SECTIONS
{
  /* The startup code goes first into FLASH */
  .vetor :
  {
    . = ALIGN(4);
    *(.vetor)
    . = ALIGN(4);
  } >FLASH

  .text :
  {
    . = ALIGN(4);
    *(.text)           
    *(.text*)          
    . = ALIGN(4);
  } >FLASH
}