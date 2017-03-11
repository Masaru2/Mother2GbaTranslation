m2_vwf_entries:

//==============================================================================
.c980c_custom_codes:
push    {r1-r2,lr}
mov     r1,r7
mov     r2,r5
bl      m2_customcodes.parse
ldr     r1,[r6,#0]

// If 0, return [r6]+2; otherwise, return [r6]+r0
beq     +
add     r0,r0,r1
pop     {r1-r2,pc}
+
add     r0,r1,#2
pop     {r1-r2,pc}

//==============================================================================
.c980c_weld_entry:
push    {r0-r1,lr}
mov     r0,r5
mov     r1,r7
bl      m2_vwf.weld_entry
pop     {r0-r1,pc}

//==============================================================================
.c980c_resetx:
push    {r1,lr}
mov     r1,#0
strh    r1,[r0,#2]
pop     {r1}
bl      $80C87D0
pop     {pc}

//==============================================================================
.c87d0_clear_entry:
push    {lr}

// Reset X
mov     r1,#0
strh    r1,[r0,#2]

// Clear window
mov     r1,#4
bl      m2_vwf.clear_window

// Clobbered code
ldr     r4,=#0x3005270
mov     r1,#0x24
pop     {pc}

//==============================================================================
.c9634_resetx:
push    {lr}
mov     r4,#0
strh    r4,[r6,#2]

// Clobbered code
strh    r5,[r1,#0]
pop     {pc}

//==============================================================================
.c4b2c_skip_nones:
push    {r7,lr}
add     sp,#-4
mov     r7,#0

// Get the (none) pointer
mov     r0,r4
mov     r1,r10
mov     r2,#0x2A
bl      $80BE260
mov     r5,r0

// Check each equip slot
ldr     r6,=#0x3001D40
ldr     r3,=#0x3005264
ldrh    r0,[r3,#0] // active party character
mov     r1,#0x6C
mul     r0,r1
add     r6,r0,r6
add     r6,#0x75
ldrb    r0,[r6,#0]
bne     +

// Weapon
mov     r0,r8
mov     r1,r5
mov     r2,#0x6
mov     r3,#0
str     r7,[sp,#0]
bl      $80C9634

+
ldrb    r0,[r6,#1]
bne     +

// Body
mov     r0,r8
mov     r1,r5
mov     r2,#0x6
mov     r3,#1
str     r7,[sp,#0]
bl      $80C9634

+
ldrb    r0,[r6,#2]
bne     +

// Arms
mov     r0,r8
mov     r1,r5
mov     r2,#0x6
mov     r3,#2
str     r7,[sp,#0]
bl      $80C9634

+
ldrb    r0,[r6,#3]
bne     +

// Other
mov     r0,r8
mov     r1,r5
mov     r2,#0x6
mov     r3,#3
str     r7,[sp,#0]
bl      $80C9634

+
mov     r0,#0
mov     r10,r0
add     sp,#4
pop     {r7,pc}