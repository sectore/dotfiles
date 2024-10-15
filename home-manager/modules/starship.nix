{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {

      format = lib.concatStrings [
          "$hostname"
          "$username"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$git_metrics"
          "$cmd_duration $jobs"
          "$fill"
          "$haskell"
          "$nodejs"
          "$nix_shell"
          "$rust"
          "$line_break"
          "$character"
      ];

      fill = {
        symbol = " ";
        disabled = false;
      };

      add_newline = true;

      character = {
        success_symbol = "[❯](bold cyan)";
        error_symbol = "[✗](bold red)";
      };

      directory = {
        format = "[ $path ]($style)";
        style = "bold white bg:bright-black";
        truncation_length = 10;
        truncate_to_repo = false;
      };

      hostname = {
        ssh_only = true;
        format = "[$ssh_symbol$hostname]($style) ";
        style = "dimmed bold green";
      };

      username = {
        show_always = false;
        format = "[$user]($style) ";
        style_user = "bold dimmed green";
      };

      git_branch = {
        format = "[ $symbol$branch(:$remote_branch) ]($style) ";
        style = "blue bg:bright-cyan";
      };

      git_status = {
        style = "cyan";
      };

      haskell = {
        format = "[$symbol($version )]($style)";
        style = "purple";
      };

      nodejs = {
        format = "[$symbol($version )]($style)";
        style = "bold blue";
        detect_files = [
          "package.json"
          ".nvmrc"
        ];
      };

      rust = {
        format = "[$symbol($version )]($style)";
      };

      nix_shell = {
        format = "[$symbol$state( \($name\))]($style)";
      };

      jobs = {
        symbol = "⚙";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "orange";
      };

      time = {
        format = "[$time]($style) ";
        style = "bright-black";
        disabled = false;
      };

      package = {
        disabled = true;
      };

    };      
  };
}
