typedef unsigned char byte;
#define QUESTION_MARK 0x1F;
#define CPUFASTSET_FILL (0x1000000)
#define TRUE 1
#define FALSE 0

unsigned short *tile_offset = (unsigned short*)0x30051EC;
unsigned short *palette_mask = (unsigned short*)0x3005228;
unsigned short **tilemap_pointer = (unsigned short**)0x3005270;
int *vram = (int*)0x6000000;

int *m2_misc_offsets = (int*)0x8B17EE4;
byte *m2_misc_strings = (byte*)0x8B17424;

byte decode_character(byte chr);
int get_tile_number(int x, int y);
int expand_bit_depth(byte row, int foreground);
byte reduce_bit_depth(int row, int foreground);
byte print_character(byte chr, int x, int y, int font, int foreground);
void print_special_character(int tile, int x, int y);
byte print_character_with_callback(byte chr, int x, int y, int font, int foreground,
    int *dest, int (*getTileCallback)(int, int), int useTilemap);
byte print_character_to_ram(byte chr, int *dest, int xOffset, int font, int foreground);
int print_window_header_string(int *dest, byte *str, int x, int y);
void clear_window_header(int *dest);
unsigned short* print_equip_header(int type, unsigned short *tilemap, unsigned int *dest,
    WINDOW *window);
void weld_entry(WINDOW *window, byte *str);
void weld_entry_custom(WINDOW *window, byte *str, int font, int foreground);
void clear_tile(int x, int y, int pixels);
void clear_rect(int x, int y, int width, int height, int pixels);
void clear_rect_ram(int *dest, int tileCount, int pixels);
void clear_window(WINDOW *window);
void print_blankstr(int x, int y, int width);
void copy_tile(int xSource, int ySource, int xDest, int yDest);
void copy_tile_up(int x, int y);
void print_space(WINDOW *window);

extern unsigned short m2_coord_table[];
extern int m2_bits_to_nybbles[];
extern byte m2_nybbles_to_bits[];
extern byte *m2_font_table[];
extern byte m2_font_widths[];
extern byte m2_font_heights[];
extern unsigned short *m2_widths_table[];
extern byte m12_other_str5[];
extern byte m12_other_str6[];
extern byte m12_other_str7[];
extern byte m12_other_str8[];

extern void cpufastset(void *source, void *dest, int mode);
extern byte* m2_strlookup(int *offset_table, byte *strings, int index);
