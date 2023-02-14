''
  function f
      FZF_DEFAULT_COMMAND='fd  --type f --hidden --follow --exclude .git'  FZF_DEFAULT_OPTS="--color=bg+:#FAF4FC,bg:#EFF1F5,spinner:#F8BD96,hl:#F28FAD  --color=fg:#414868,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96  --color=marker:#F8BD96,fg+:#BC8AA5,prompt:#DDB6F2,hl+:#F28FAD  --preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color 'border:#b48ead'
  end
''
