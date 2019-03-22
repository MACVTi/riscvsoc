_estack = 0x00000040;
ENTRY(__entry);

SECTIONS
{
    . = 0x0;
    .text :
    {
        *(.text.prologue);
        *(.text);
    }
    .data :
    {
    }
    .sdata :
    {
    }
    .bss :
    {
    }
}
