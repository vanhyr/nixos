{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nil
    nixd
  ];
  programs.zed-editor = {
    enable = true;
    extensions = [
      # themes
      "catppuccin"
      # icon themes
      "catppuccin-icons"
      # languages
      "html"
      "git-firefly"
      "toml"
      "dockerfile"
      "php"
      "make"
      "xml"
      "lua"
      "zig"
      "nix"
      "docker-compose"
      "ini"
      "fish"
      "ansible"
      "just"
      "json5"
      "ssh-config"
      "hyprlang"
     ];
     userKeymaps = [
      {
        "context" = "Workspace";
        "bindings" = {
          #"shift shift" = "file_finder::Toggle";
        };
      }
      {
      "context" = "Editor && vim_mode == insert";
        "bindings" = {
          "j k" = "vim::NormalBefore";
        };
      }
      {
        "context" = "Editor && vim_mode == visual";
        "bindings" = {
          #"<" = "vim::PushOutdent";
          #">" = "vim::PushIndent";
          "<" = "editor::Outdent";
          ">" = "editor::Indent";
        };
      }
    ];
    userSettings = {
      icon_theme = "Catppuccin Mocha";
      theme = {
        mode = "system";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };
      # theme_overrides = {
      #   "Catppuccin Mocha" = {
      #     border = "#89B4FA";
      #   };
      # };

      outline_panel.dock = "left";
      git_panel.dock = "left";
      project_panel.dock = "left";
      collaboration_panel.button = false;
      debugger.button = false;

      edit_predictions = {
        provider = "zed";
        allow_data_collection = "no";
      };

      agent = {
        sidebar_side = "right";
        default_profile = "write";
        default_model = {
          effort = "minimal";
          provider = "google";
          model = "gemini-3.5-flash";
          enable_thinking = false;
        };
        enable_feedback = false;
        dock = "right";
        favorite_models = [
          {
            provider = "google";
            model = "gemini-2.5-flash";
            enable_thinking = true;
          }
          {
            provider = "google";
            model = "gemini-2.5-flash-lite";
            enable_thinking = true;
          }
          {
            provider = "google";
            model = "gemini-3.5-flash";
            enable_thinking = false;
            effort = "minimal";
          }
        ];
        model_parameters = [ ];
      };

      tabs.file_icons = true;
      title_bar = {
        show_sign_in = false;
        show_user_picture = true;
        show_user_menu = true;
        show_branch_status_icon = false;
      };
      colorize_brackets = true;
      agent_servers = { };
      cli_default_open_behavior = "existing_window";

      hard_tabs = false;
      tab_size = 2;

      proxy = "";

      ui_font_family = "JetBrainsMono Nerd Font Mono";
      buffer_font_family = "JetBrainsMono Nerd Font Mono";

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      ui_font_size = 16;
      buffer_font_size = 16.0;

      vim_mode = true;
      vim.toggle_relative_line_numbers = true;

      load_direnv = "direct";
      #load_direnv = "shell_hook";
    };
  };
}
