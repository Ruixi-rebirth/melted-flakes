({ config, ... }:

{
  environment.systemPackages = [ 
    config.nur.repos.linyinfeng.icalingua-plus-plus
    config.nur.repos.eh5.netease-cloud-music
  ];
})
