{ pkgs ? null, hyprctl ? null, ... }:
pkgs.writeTextFile {
  name = "waybar-hyprctl.diff";
  text = ''
    diff --git a/src/modules/wlr/workspace_manager.cpp b/src/modules/wlr/workspace_manager.cpp
    index da83cb7..4c33ac3 100644
    --- a/src/modules/wlr/workspace_manager.cpp
    +++ b/src/modules/wlr/workspace_manager.cpp
    @@ -450,7 +450,8 @@ auto Workspace::handle_clicked(GdkEventButton *bt) -> bool {
       if (action.empty())
         return true;
       else if (action == "activate") {
    -    zext_workspace_handle_v1_activate(workspace_handle_);
    +    const std::string command = "${hyprctl} dispatch workspace " + name_;
    +       system(command.c_str());
       } else if (action == "close") {
         zext_workspace_handle_v1_remove(workspace_handle_);
       } else {
  '';
}
