/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 0;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 1;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const unsigned int gappih    = 8;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 8;       /* vert inner gap between windows */
static const unsigned int gappoh    = 8;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 8;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 8;       /* vertical padding of bar */
static const int sidepad            = 8;       /* horizontal padding of bar */
static const char *fonts[]          = {
  "JetBrainsMono Nerd Font Mono:size=12:antialias=true:autohint=true",
  "Noto Color Emoji:size=12:antialias=true:autohint=true",
  "monospace:size=10"
};
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
//static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const char *tags[] = { "", "󰾔", "󱃖", "󱩼", "󰀆", "󰎄", "󰌲", "󰋩", "󰢔", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                        instance              title                               tags mask   isfloating  isterminal    noswallow  monitor  float x,y,w,h   floatborderpx   scratch key */
  { "kitty",                      NULL,                 NULL,                               0,          0,          1,            0,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "Nsxiv",                      NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "mpv",                        NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "pavucontrol",                NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ ".blueman-manager-wrapped",   NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "Lxappearance",               NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "Nwg-look",                   NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "Arandr",                     NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
  { "firefox",                    NULL,                 NULL,                               1 << 1,     0,          0,            -1,       -1,       -1,-1,-1,-1,    -1,             0   },
	{ "firefox",                    "Places",             NULL,                               1 << 1,     1,          0,            -1,       -1,       -1,-1,-1,-1,    -1,             0   },
	{ "firefox",                    NULL,                 "About Mozilla Firefox",            1 << 1,     1,          0,            -1,       -1,       -1,-1,-1,-1,    -1,             0   },
  { "Helium",                     NULL,                 NULL,                               1 << 1,     0,          0,            -1,       -1,       -1,-1,-1,-1,    -1,             0   },
  { "Brave-browser",              NULL,                 NULL,                               1 << 1,     0,          0,            -1,       -1,       -1,-1,-1,-1,    -1,             0   },
  { "dev.zed.Zed",                NULL,                 NULL,                               1 << 2,     0,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
  //{ "dev.zed.Zed",                NULL,                 "Zed â\302\200\302\224 Settings",   1 << 2,     1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	//{ "Thunar",                     NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
  { "Spotube",                    NULL,                 NULL,                               1 << 5,     0,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
  { "Hypnotix.py",                NULL,                 NULL,                               1 << 6,     0,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ "Gimp",                       NULL,                 NULL,                               1 << 7,     1,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   },
	{ NULL,                         NULL,                 "Event Tester",                     0,          0,          0,            1,        -1,       -1,-1,-1,-1,    -1,             0   }, /* xev */
  
  /* scratchpads */
  { "scratch_term",               NULL,                 NULL,                               0,          1,          0,            0,        -1,       -1,6,60,60,     -1,             't' }, /* scratchpad terminal */
	{ "Thunar",                     "Thunar",             NULL,                               0,          1,          0,            1,        -1,       -1,6,80,80,     -1,             'e' }, /* scratchpad explorer (thunar) */
	{ "scratch_btop",               NULL,                 NULL,                               0,          1,          0,            1,        -1,       -1,6,59,70,     -1,             'b' }, /* scratchpad btop */
	{ "ZapZap",                     "zapzap",             NULL,                               0,          1,          0,            1,        -1,       -1,6,80,80,     -1,             'w' }, /* scratchpad whatsapp (zapzap) */
	//{ "WhatSie",                    "whatsie",            NULL,                               0,          1,          0,            1,        -1,       -1,6,80,80,     -1,             'w' }, /* scratchpad whatsapp (whatsie) */
	{ "Todoist",                    "todoist",            NULL,                               0,          1,          0,            1,        -1,       -1,6,80,80,     -1,             'm' }, /* scratchpad todoist (todoist-electron)*/
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	//{ "[@]",      spiral },
	//{ "[\\]",     dwindle },
	//{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	//{ "HHH",      grid },
	//{ "###",      nrowgrid },
	//{ "---",      horizgrid },
	//{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	//{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask // SUPER key

#define TAGKEYS(KEY,TAG) \
	&((Keychord){ 1, {{MODKEY,                        KEY}},    view,         {.ui = 1 << TAG} }), \
	&((Keychord){ 1, {{MODKEY|ControlMask,            KEY}},    toggleview,   {.ui = 1 << TAG} }), \
	&((Keychord){ 1, {{MODKEY|ShiftMask,              KEY}},    tag,          {.ui = 1 << TAG} }), \
	&((Keychord){ 1, {{MODKEY|ControlMask|ShiftMask,  KEY}},    toggletag,    {.ui = 1 << TAG} }),

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
//static const char *menucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *dmenucmd[] = { "rofi", "-show", "drun" , "-show-icons", NULL };
static const char *termcmd[]  = { "kitty", NULL };

/* first arg only serves to match against key in rules*/
static const char *scratchtermcmd[] = {"t", "kitty", "--app-id", "scratch_term", NULL};
static const char *scratchexplorercmd[] = {"e", "thunar", NULL};
static const char *scratchbtopcmd[] = {"b", "kitty", "--app-id", "scratch_btop", "btop", NULL};
static const char *scratchwhatsappcmd[] = {"w", "zapzap", NULL};
//static const char *scratchwhatsappcmd[] = {"w", "whatsie", NULL};
static const char *scratchtodoistcmd[] = {"m", "todoist-electron", NULL};

/* KEYBINDS (Supports Keychords) */
static const Keychord *keychords[] = {
	/* nKchord         modifier,                        key             function          argument */
  &((Keychord){ 1, {{MODKEY,                          XK_Return}},    spawn,            SHCMD("$TERMINAL") }),
  &((Keychord){ 1, {{MODKEY,                          XK_b}},         spawn,            SHCMD("$BROWSER") }),
  &((Keychord){ 2, {{MODKEY|ShiftMask,                XK_b},
                    {0,                               XK_b}},         spawn,            SHCMD("brave") }),
  &((Keychord){ 1, {{MODKEY,                          XK_e}},         spawn,            SHCMD("$FILE_EXPLORER") }),
  
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_p}},         spawn,            {.v = dmenucmd } }),

  // scratchpads
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_Return}},    togglescratch,    {.v = scratchtermcmd} }),
  //&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_g}},         togglescratch,    {.v = "b", "kitty", "--app-id", "scratch_btop", "btop", NULL} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_e}},         togglescratch,    {.v = scratchexplorercmd} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_g}},         togglescratch,    {.v = scratchbtopcmd} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_w}},         togglescratch,    {.v = scratchwhatsappcmd} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_t}},         togglescratch,    {.v = scratchtodoistcmd} }),

  // screenshots
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_s},
                    {0,                               XK_a}},         spawn,            SHCMD("scrot '%Y-%m-%d-%H%M%S_$wx$h.png' -e 'mv $f ~/img/scrots/'") }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_s},
                    {0,                               XK_s}},         spawn,            SHCMD("scrot -s '%Y-%m-%d-%H%M%S_$wx$h.png' -e 'mv $f ~/img/scrots/'") }),

  //&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_b}},         togglebar,        {0} }),

  &((Keychord){ 1, {{MODKEY,                          XK_j}},         focusstack,       {.i = +1 } }),
	&((Keychord){ 1, {{MODKEY,                          XK_k}},         focusstack,       {.i = -1 } }),
	&((Keychord){ 1, {{MODKEY,                          XK_i}},         incnmaster,       {.i = +1 } }),
	&((Keychord){ 1, {{MODKEY,                          XK_d}},         incnmaster,       {.i = -1 } }),
	//&((Keychord){ 1, {{MODKEY,                          XK_h}},         setmfact,         {.f = -0.05} }),
	//&((Keychord){ 1, {{MODKEY,                          XK_l}},         setmfact,         {.f = +0.05} }),
	&((Keychord){ 1, {{MODKEY,                          XK_h}},         setmfact,         {.f = -0.1} }),
	&((Keychord){ 1, {{MODKEY,                          XK_l}},         setmfact,         {.f = +0.1} }),
	//&((Keychord){ 1, {{MODKEY,                          XK_o}},         setmfact,         {.f = 0.00} }), // doesn't work
	
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_j}},         rotatestack,      {.i = +1 } }),
	&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_k}},         rotatestack,      {.i = -1 } }),

  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_l}},         setcfact,         {.f = -0.25} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_h}},         setcfact,         {.f = +0.25} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_o}},         setcfact,         {.f =  0.00} }),

  //&((Keychord){ 1, {{MODKEY,                          XK_z}},         zoom,             {0} }),

  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_f}},         togglefullscr,    {0} }),
  
  &((Keychord){ 1, {{MODKEY,                          XK_Tab}},       view,             {0} }),
	&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_c}},         killclient,       {0} }),
	
  //&((Keychord){ 1, {{MODKEY,                          XK_t}},         setlayout,        {.v = &layouts[0]} }),
	//&((Keychord){ 1, {{MODKEY,                          XK_f}},         setlayout,        {.v = &layouts[1]} }),
	//&((Keychord){ 1, {{MODKEY,                          XK_m}},         setlayout,        {.v = &layouts[2]} }),
  &((Keychord){ 2, {{MODKEY,                          XK_l},
                    {0,                               XK_t}},         setlayout,        {.v = &layouts[0]} }),
  &((Keychord){ 2, {{MODKEY,                          XK_l},
                    {0,                               XK_f}},         setlayout,        {.v = &layouts[5]} }),
  &((Keychord){ 2, {{MODKEY,                          XK_l},
                    {0,                               XK_m}},         setlayout,        {.v = &layouts[1]} }),
	
  &((Keychord){ 1, {{MODKEY,                          XK_space}},     setlayout,        {0} }),
	//&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_space}},     togglefloating,   {0} }),
	&((Keychord){ 1, {{MODKEY,                          XK_v}},         togglefloating,   {0} }),
	
  //&((Keychord){ 1, {{MODKEY,                          XK_0}},         view,             {.ui = ~0 } }),
	//&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_0}},         tag,              {.ui = ~0 } }),
	
  &((Keychord){ 1, {{MODKEY,                          XK_comma}},     focusmon,         {.i = -1 } }),
	&((Keychord){ 1, {{MODKEY,                          XK_period}},    focusmon,         {.i = +1 } }),
	&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_comma}},     tagmon,           {.i = -1 } }),
	&((Keychord){ 1, {{MODKEY|ShiftMask,                XK_period}},    tagmon,           {.i = +1 } }),
	
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_q}},         spawn,            {.v = (const char*[]){ "rofi-power", NULL } } }),
  //&((Keychord){ 1, {{MODKEY|ControlMask|ShiftMask,    XK_q}},         quit,             {0} }),
  &((Keychord){ 1, {{MODKEY|ShiftMask,                XK_r}},         quit,             {1} }),
  

  /* TAGS */
  TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        XK_0,                      9)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	//{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

