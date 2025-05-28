{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;
    delta.enable = true;

    userName = "Odrian";
    userEmail = "adrian46tver@bk.ru";

    # signing = {
      # signByDefault = true;
      # key = "3C23C7BD99452036";
    # };

    extraConfig = {
      core.editor = "micro";
      init.defaultBranch = "main";
      # pull.rebase = true;
      # push.autoSetupRemote = true;
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # helix-gpt
      rust-analyzer # rust lsp
      nil nixd nixpkgs-fmt # nix lsp
    ];
    settings.theme = "sonokai";
    settings.editor = {
      line-number = "relative";
    };
    settings.keys.normal = {
      "backspace" = {
        e = [ ":w" ":sh cargo build" ];
        f = [ ":w" ":sh cargo fmt" ];
        r = ":wq";
        s = ":w";
        S = ":config-reload";
        c = ":config-open";
      };
      "C-k" = [ # scroll selections up one line
          "ensure_selections_forward"
          "extend_to_line_bounds"
          "extend_char_right"
          "extend_char_left"
          "delete_selection"
          "move_line_up"
          "add_newline_above"
          "move_line_up"
          "replace_with_yanked"
      ];
      "C-j" = [ # scroll selections down one line
          "ensure_selections_forward"
          "extend_to_line_bounds"
          "extend_char_right"
          "extend_char_left"
          "delete_selection"
          "add_newline_below"
          "move_line_down"
          "replace_with_yanked"
      ];
      # dublicate line
      ",".d = [ "save_selection" "extend_to_line_bounds" "yank" "paste_before" "jump_backward" ];
      # ",".D = [ "save_selection" "extend_to_line_bounds" "toggle_comments" "yank" "paste_before" "jump_backward" "toggle_comments" ];
    };
    languages = {
      # language-server.rust-analyzer.config.check = {
        # command = "clippy";
      # };
      # language-server.gpt = {
        # command = "helix-gpt";
        # args = [ "--handler" "copilot" ];
      # };
    };
    languages.language = [
      {
        name = "rust";
        language-servers = [ "rust-analyzer" ]; # "gpt"
        indent = { tab-width = 4; unit = "    "; };
        auto-format = true;
      }
      {
        name = "nix";
        formatter = { command = "nixpkgs-fmt"; };
        auto-format = true;
      }
    ];
  };
}
