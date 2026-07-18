#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
//#define DELIMITER "  "
#define DELIMITER " "
//#define DELIMITER " | "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
//#define CLICKABLE_BLOCKS 1
#define CLICKABLE_BLOCKS 0 // disabled until statuscmd is patched into dwm

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X) \
  X("", "$HOME/.local/bin/widgets/cpu", 2, 0) \
  X("", "$HOME/.local/bin/widgets/memory", 5, 0) \
  X("", "$HOME/.local/bin/widgets/coretemp", 3, 0) \
  X("", "$HOME/.local/bin/widgets/volume", 0, 10) \
  X("", "$HOME/.local/bin/widgets/brightness", 0, 20) \
  X("", "$HOME/.local/bin/widgets/battery", 60, 0) \
  X("", "$HOME/.local/bin/widgets/clock", 60, 0) \

#endif  // CONFIG_H
