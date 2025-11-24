# Shell aliases configuration
# This file contains all shell aliases for better organization

{
  # Modern replacements
  ls  = "eza --icons=always";
  ll  = "eza -l --icons=always";
  la  = "eza -la --icons=always";
  cat = "bat --plain";

  # Git shortcuts
  g  = "git";
  gs = "git status";
  ga = "git add";
  gcm = "git commit -m";
  gp  = "git push";
  gl  = "git pull";

  # kubectl aliases
  k     = "kubectl";
  kg    = "kubectl get";
  kn    = "kubectl-ns";
  kns   = "kubectl node-shell";
  kgns  = "kubectl get ns";
  kgp   = "kubectl get pods";
  kgd   = "kubectl get deploy";
  kdd   = "kubectl describe deploy";
  kga   = "kubectl get applications -n argocd";
  kgas  = "kubectl get applicationset -n argocd";
  kgsts = "kubectl get sts";
  kda   = "kubectl describe apps -n argocd";
  kdas  = "kubectl describe appset -n argocd";
  kgpa  = "kubectl get pods --all-namespaces";
  kd    = "kubectl describe";
  kdp   = "kubectl describe pod";
  kl    = "kubectl logs";
  kdelp = "kubectl delete pod";
  kaf   = "kubectl apply -f";
  kdf   = "kubectl delete -f";
  kgs   = "kubectl get services";
  kgsec = "kubectl get secrets";
  kgn   = "kubectl get nodes";
  kexec = "kubectl exec -it";
  kge   = "kubectl get events";
  kgj   = "kubectl get jobs";
  kgcj  = "kubectl get cronjobs";
  kvs   = "kubectl view-secret";
  ktn   = "kubectl top nodes";
  ktp   = "kubectl top pods";
  ## Crossplane
  kgc   = "kubectl get composition";
  kdci  = "kubectl delete composition";
  kgx   = "kubectl get xrd";
  kdx   = "kubectl delete xrd";
  kgo   = "kubectl get objects";
  kdo   = "kubectl delete objects";
  kgm   = "kubectl get managed";
  kgxp  = "kubectl get providers";
  kgxpv = "kubectl get pkgrev";

  # Utilities
  h     = "htop";

  # Terraform/OpenTofu shortcuts
  tf    = "tofu";
  tfi   = "tofu init";
  tg    = "terragrunt";
  tfa   = "tofu apply";
  tfp   = "tofu plan";
  tgi   = "terragrunt init";
  tgp   = "terragrunt plan";
  tga   = "terragrunt apply";
  tgaa  = "terragrunt apply -auto-approve";
  tgri  = "terragrunt run --all init";
  tgrp  = "terragrunt run --all plan";
  tgra  = "terragrunt run --all apply";
  tgraa = "terragrunt run --all --non-interactive apply";
  tgd   = "terragrunt destroy";
  tgda  = "terragrunt destroy -auto-approve";

  # Docker/Podman aliases
  d      = "docker";
  dc     = "docker-compose";
  dps    = "docker ps";
  dpsa   = "docker ps -a";
  di     = "docker images";
  dex    = "docker exec -it";
  dlogs  = "docker logs";
  dstop  = "docker stop";
  drm    = "docker rm";
  drmi   = "docker rmi";
  dprune = "docker system prune -af";

  # Podman aliases
  p      = "podman";
  pc     = "podman-compose";
  pps    = "podman ps";
  ppsa   = "podman ps -a";
  pi     = "podman images";
  pex    = "podman exec -it";
  plogs  = "podman logs";
  pstop  = "podman stop";
  prm    = "podman rm";
  prmi   = "podman rmi";
  pprune = "podman system prune -af";

  # Gcloud aliases
  gc     = "gcloud";
  gac    = "gcloud auth list";
  gcl    = "gcloud config list";
  gsl    = "gcloud services list";
  gal    = "gcloud auth login";
  gaal   = "gcloud auth application-default login";
  gat    = "gcloud auth application-default print-access-token";


  # Custom + System
  nf       = "neofetch";
  free     = "top -l 1 -s 0 | grep PhysMem";
  cpu      = "sysctl -a | grep machdep.cpu";
  gpu      = "system_profiler SPDisplaysDataType";
  projects = ''cd ~/Library/"Mobile Documents"/com~apple~CloudDocs/projects'';
  update   = ''cd ~/Library/"Mobile Documents"/com~apple~CloudDocs/projects/nixos-configs-mac && sudo darwin-rebuild switch --flake ".#$(hostname | sed "s/\./-/g")"'';
  upgrade  = ''cd ~/Library/"Mobile Documents"/com~apple~CloudDocs/projects/nixos-configs-mac && nix flake update && sudo darwin-rebuild switch --flake ".#$(hostname | sed "s/\./-/g")"'';
  cleanup  = "nix-collect-garbage -d";

  # Navigation
  ".." = "cd ..";
  "..." = "cd ../..";
}

