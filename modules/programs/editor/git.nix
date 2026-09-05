{ ... }:
let
  homeManager = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Max Su";
          email = "max@maxsu.dev";
        };
        init.defaultBranch = "main";
      };
      includes = [
        {
          condition = "gitdir:~/Code/saccharine/";
          contents = {
            user = {
              name = "frieren";
              email = "lilaclapras@gmail.com";
            };
          };
        }
      ];
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
