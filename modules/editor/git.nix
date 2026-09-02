{ ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "mix";
        user.email = "max@maxsu.dev";
        init.defaultBranch = "main";
      };
      includes = [
        {
          condition = "gitdir:~/Code/saccharine/";
          contents.user = {
            name = "frieren";
            email = "lilaclapras@gmail.com";
          };
        }
      ];
    };
  };
}
