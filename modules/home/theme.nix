{
  # ============================================================================
  # Utility Functions
  # ============================================================================

  # Strip the # from hex colors (for terminals that don't need the #)
  rawHexValue = color: builtins.substring 1 6 color;

  # Convert hex to RGB tuple (for some applications)
  hexToRgb = color: {
    r = builtins.substring 0 2 (rawHexValue color);
    g = builtins.substring 2 2 (rawHexValue color);
    b = builtins.substring 4 2 (rawHexValue color);
  };

  # ============================================================================
  # Edo Color Palette
  # A beautiful, carefully crafted dark theme with excellent contrast
  # ============================================================================

  colors = {
    # Accent Colors - Vibrant and expressive
    rosewater = "#C97D6E";  # Warm pink-red, great for highlights
    flamingo = "#C98A7D";  # Softer pink
    pink = "#BC76C1";       # Vibrant magenta
    mauve = "#6872AB";      # Muted purple-blue
    red = "#CB7676";        # Error, warnings
    maroon = "#CC8D82";     # Softer red
    peach = "#CC8D70";      # Warm orange
    yellow = "#CC9B70";     # Warning, highlights
    green = "#80A665";      # Success, positive actions
    teal = "#5EA994";       # Info, secondary actions
    sky = "#5D9AA9";        # Light blue
    sapphire = "#6394BF";   # Rich blue
    blue = "#687EAA";       # Primary actions, links
    lavender = "#4C8E72";   # Muted green-blue

    # Text Colors - Hierarchical text colors for readability
    text = "#D8D6C9";       # Primary text (highest contrast)
    subtext1 = "#B2B0A6";   # Secondary text
    subtext0 = "#999895";   # Tertiary text
    overlay2 = "#7F7F7C";   # Disabled text
    overlay1 = "#666666";   # Very dim text
    overlay0 = "#4C4C4C";   # Almost invisible text

    # Surface Colors - Background layers (lightest to darkest)
    surface2 = "#333333";   # Lightest surface (hover states)
    surface1 = "#232323";   # Medium surface (panels, cards)
    surface0 = "#1E1E1E";   # Dark surface (modals, dropdowns)
    base = "#121212";       # Main background
    mantle = "#0A0A0A";     # Secondary background
    crust = "#000000";      # Darkest background (borders, dividers)
  };

  # ============================================================================
  # Semantic Color Mappings
  # Use these for consistent meaning across applications
  # ============================================================================

  semantic = {
    # Status Colors
    success = colors.green;
    warning = colors.yellow;
    error = colors.red;
    info = colors.blue;

    # UI Element Colors
    primary = colors.blue;        # Primary actions, buttons
    secondary = colors.teal;      # Secondary actions
    accent = colors.rosewater;    # Accent highlights
    muted = colors.subtext1;      # Muted text

    # Border & Divider Colors
    border = colors.surface2;      # Standard borders
    borderSubtle = colors.surface1; # Subtle borders
    divider = colors.crust;       # Dividers between sections

    # Selection & Focus
    selection = colors.surface2;   # Selected items
    focus = colors.blue;          # Focus ring
    hover = colors.surface1;      # Hover state
  };

  # ============================================================================
  # Git/Delta Diff Colors
  # Optimized for code review and git diffs
  # ============================================================================

  diff = {
    hunkHeader = "#23273D";
    minusEmph = "#53394c";        # Deleted lines (emphasized)
    minus = "#34293a";            # Deleted lines
    plusEmph = "#404f4a";         # Added lines (emphasized)
    plus = "#2c3239";             # Added lines
    purple = "#494060";           # Context lines
    blue = "#384361";             # Modified lines
    cyan = "#384d5d";             # Special diff markers
    yellow = "#544f4e";           # Highlighted changes
  };

  # ============================================================================
  # Editor UI Colors
  # For code editors and IDEs
  # ============================================================================

  ui = {
    findHighlight = "#3e5767";           # Search highlight
    lineNumber = colors.subtext0;         # Line numbers
    lineNumberActive = colors.text;       # Active line number
    indentGuide = colors.surface1;        # Indentation guides
    bracketMatch = colors.blue;           # Matching brackets
    bracketMatchBg = colors.surface1;     # Matching bracket background
    wordHighlight = colors.surface1;      # Word highlight
    wordHighlightStrong = colors.surface2; # Strong word highlight
  };

  # ============================================================================
  # Terminal-Specific Color Mappings
  # Optimized for terminal emulators
  # ============================================================================

  terminal = {
    # Standard ANSI colors (0-15)
    black = colors.surface1;
    red = colors.red;
    green = colors.green;
    yellow = colors.yellow;
    blue = colors.blue;
    magenta = colors.pink;
    cyan = colors.teal;
    white = colors.subtext1;

    # Bright variants
    brightBlack = colors.surface2;
    brightRed = colors.red;
    brightGreen = colors.green;
    brightYellow = colors.yellow;
    brightBlue = colors.blue;
    brightMagenta = colors.pink;
    brightCyan = colors.teal;
    brightWhite = colors.subtext0;

    # Special terminal colors
    cursor = colors.rosewater;
    cursorText = colors.crust;
    selection = colors.surface2;
    selectionText = colors.text;
  };

  # ============================================================================
  # Theme Metadata
  # ============================================================================

  meta = {
    name = "Edo";
    variant = "dark";
    author = "Custom";
    description = "A carefully crafted dark theme with excellent contrast and readability";
  };
}
