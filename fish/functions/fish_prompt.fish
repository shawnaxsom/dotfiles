# Defined in /var/folders/2m/zlrrw3z52vv6pv4bjt50gzq00000gp/T//fish.r744UE/fish_prompt.fish @ line 2
function fish_prompt --description 'Write out the prompt'
	if not set -q __fish_prompt_hostname
       set -g __fish_prompt_hostname (hostname -s)
   end

   if not set -q __fish_prompt_normal
       set -g __fish_prompt_normal (set_color normal)
   end

   if not set -q __fish_prompt_cwd
       set -g __fish_prompt_cwd (set_color $fish_color_cwd)
   end

   if set -q VIRTUAL_ENV
       echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
   end

   echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) (__fish_git_prompt) "$__fish_prompt_normal" '> '
end
