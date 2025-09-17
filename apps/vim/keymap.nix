{ lib, ... }:
let
  customBinding =
    input:
    lib.flatten (
      lib.mapAttrsToList (
        mode: action:
        map (key: {
          mode = [ mode ];
          inherit key;
          inherit action;
          inherit (input) desc;
        }) input.keys
      ) input.actions
    );
in
(customBinding {
  keys = [
    "<C-Up>"
    "<C-k>"
  ];
  actions = {
    "n" = ":move .-2<CR>";
    "i" = "<Esc>:move .-2<CR>gi";
    "v" = ":move '<-2<CR>gv";
  };
  desc = "Move line up";
})
++ (customBinding {
  keys = [
    "<C-Down>"
    "<C-j>"
  ];
  actions = {
    "n" = ":move .+1<CR>";
    "i" = "<Esc>:move .+1<CR>gi";
    "v" = ":move '>+1<CR>gv";
  };
  desc = "Move line down";
})
++ (customBinding {
  keys = [
    "<C-Right>"
    "<C-l>"
  ];
  actions = {
    "n" = ">>";
    "i" = "<Esc>>>gi";
    "v" = ">gv";
  };
  desc = "Indent line";
})
++ (customBinding {
  keys = [
    "<C-Left>"
    "<C-h>"
  ];
  actions = {
    "n" = "<<";
    "i" = "<Esc><<gi";
    "v" = "<gv";
  };
  desc = "Deindent line";
})
