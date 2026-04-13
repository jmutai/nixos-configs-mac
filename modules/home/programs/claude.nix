{ config, lib, pkgs, ... }:
let
  jsonFormat = pkgs.formats.json { };
  claudeSettings = {
    permissions = {
      allow = [
        # Filesystem navigation
        "Bash(cd *)"
        "Bash(ls *)"
        "Bash(pwd)"
        "Bash(tree *)"
        "Bash(file *)"
        "Bash(stat *)"
        "Bash(du *)"
        "Bash(df *)"
        "Bash(open *)"

        # File inspection & text processing
        "Bash(cat *)"
        "Bash(head *)"
        "Bash(tail *)"
        "Bash(wc *)"
        "Bash(which *)"
        "Bash(echo *)"
        "Bash(grep *)"
        "Bash(rg *)"
        "Bash(find *)"
        "Bash(diff *)"
        "Bash(sort *)"
        "Bash(uniq *)"
        "Bash(jq *)"
        "Bash(yq *)"
        "Bash(sed *)"
        "Bash(awk *)"
        "Bash(xargs *)"
        "Bash(cut *)"
        "Bash(tr *)"

        # System info
        "Bash(date *)"
        "Bash(whoami)"
        "Bash(hostname)"
        "Bash(uname *)"
        "Bash(env *)"
        "Bash(printenv *)"
        "Bash(man *)"
        "Bash(ps *)"
        "Bash(top *)"
        "Bash(lsof *)"

        # File operations (rm stays prompted)
        "Bash(mkdir *)"
        "Bash(touch *)"
        "Bash(cp *)"
        "Bash(mv *)"
        "Bash(chmod *)"
        "Bash(ln *)"
        "Bash(tar *)"
        "Bash(zip *)"
        "Bash(unzip *)"

        # Git (read)
        "Bash(git status*)"
        "Bash(git log*)"
        "Bash(git diff*)"
        "Bash(git show*)"
        "Bash(git remote*)"
        "Bash(git stash list*)"
        "Bash(git blame*)"
        "Bash(git tag -l*)"
        "Bash(git tag --list*)"
        "Bash(git branch -a*)"
        "Bash(git branch -l*)"
        "Bash(git branch --list*)"
        "Bash(git branch -r*)"
        "Bash(git branch -v*)"

        # Git (write — push/reset/force/branch -D stay prompted)
        "Bash(git add *)"
        "Bash(git commit *)"
        "Bash(git checkout *)"
        "Bash(git switch *)"
        "Bash(git merge *)"
        "Bash(git rebase *)"
        "Bash(git stash push*)"
        "Bash(git stash pop*)"
        "Bash(git stash apply*)"
        "Bash(git stash drop*)"
        "Bash(git fetch*)"
        "Bash(git pull*)"
        "Bash(git cherry-pick*)"
        "Bash(git branch --create*)"
        "Bash(git branch -c*)"

        # Nix & nix-darwin (garbage-collect stays prompted)
        "Bash(nix build*)"
        "Bash(nix flake*)"
        "Bash(nix eval*)"
        "Bash(nix search*)"
        "Bash(nix develop*)"
        "Bash(nix run*)"
        "Bash(nix repl*)"
        "Bash(nix fmt*)"
        "Bash(nix log*)"
        "Bash(nix path-info*)"
        "Bash(nix show-derivation*)"
        "Bash(nix profile list*)"
        "Bash(darwin-rebuild *)"
        "Bash(sudo darwin-rebuild *)"
        "Bash(nix-env -q*)"
        "Bash(nix-env --query*)"
        "Bash(nix-shell *)"
        "Bash(home-manager generations*)"
        "Bash(home-manager switch*)"
        "Bash(home-manager build*)"

        # Homebrew (uninstall/autoremove stay prompted)
        "Bash(brew list*)"
        "Bash(brew info*)"
        "Bash(brew search*)"
        "Bash(brew install*)"
        "Bash(brew update*)"
        "Bash(brew upgrade*)"
        "Bash(brew outdated*)"
        "Bash(brew deps*)"
        "Bash(brew doctor*)"
        "Bash(brew config*)"
        "Bash(brew tap*)"
        "Bash(brew services*)"
        "Bash(brew bundle*)"
        "Bash(brew pin*)"
        "Bash(brew unpin*)"

        # Node/npm
        "Bash(npm *)"
        "Bash(npx *)"
        "Bash(node *)"
        "Bash(yarn *)"
        "Bash(pnpm *)"
        "Bash(bun *)"

        # Python
        "Bash(python*)"
        "Bash(pip *)"
        "Bash(pipx *)"
        "Bash(uv *)"
        "Bash(poetry *)"

        # Docker (safe — rm/rmi/prune/system stay prompted)
        "Bash(docker ps*)"
        "Bash(docker images*)"
        "Bash(docker build*)"
        "Bash(docker run*)"
        "Bash(docker exec*)"
        "Bash(docker logs*)"
        "Bash(docker inspect*)"
        "Bash(docker pull*)"
        "Bash(docker push*)"
        "Bash(docker tag*)"
        "Bash(docker network ls*)"
        "Bash(docker network inspect*)"
        "Bash(docker volume ls*)"
        "Bash(docker volume inspect*)"
        "Bash(docker compose up*)"
        "Bash(docker compose down*)"
        "Bash(docker compose build*)"
        "Bash(docker compose logs*)"
        "Bash(docker compose ps*)"
        "Bash(docker compose exec*)"
        "Bash(docker compose pull*)"
        "Bash(docker compose config*)"
        "Bash(docker-compose up*)"
        "Bash(docker-compose down*)"
        "Bash(docker-compose build*)"
        "Bash(docker-compose logs*)"
        "Bash(docker-compose ps*)"
        "Bash(podman ps*)"
        "Bash(podman images*)"
        "Bash(podman build*)"
        "Bash(podman run*)"
        "Bash(podman exec*)"
        "Bash(podman logs*)"
        "Bash(podman inspect*)"

        # Kubernetes (safe — delete/drain/cordon stay prompted)
        "Bash(kubectl get*)"
        "Bash(kubectl describe*)"
        "Bash(kubectl logs*)"
        "Bash(kubectl apply*)"
        "Bash(kubectl config*)"
        "Bash(kubectl port-forward*)"
        "Bash(kubectl exec*)"
        "Bash(kubectl top*)"
        "Bash(kubectl explain*)"
        "Bash(kubectl diff*)"
        "Bash(kubectl rollout status*)"
        "Bash(kubectl rollout history*)"
        "Bash(kubectl auth*)"
        "Bash(kubectl api-resources*)"
        "Bash(helm list*)"
        "Bash(helm status*)"
        "Bash(helm get*)"
        "Bash(helm show*)"
        "Bash(helm search*)"
        "Bash(helm template*)"
        "Bash(helm install*)"
        "Bash(helm upgrade*)"
        "Bash(helm repo*)"
        "Bash(helm diff*)"
        "Bash(helm lint*)"
        "Bash(k9s *)"

        # Terraform/OpenTofu/Terragrunt (safe — destroy/apply stay prompted)
        "Bash(terraform init*)"
        "Bash(terraform plan*)"
        "Bash(terraform fmt*)"
        "Bash(terraform validate*)"
        "Bash(terraform show*)"
        "Bash(terraform output*)"
        "Bash(terraform state list*)"
        "Bash(terraform state show*)"
        "Bash(terraform providers*)"
        "Bash(terraform graph*)"
        "Bash(terraform workspace list*)"
        "Bash(terraform workspace show*)"
        "Bash(tofu init*)"
        "Bash(tofu plan*)"
        "Bash(tofu fmt*)"
        "Bash(tofu validate*)"
        "Bash(tofu show*)"
        "Bash(tofu output*)"
        "Bash(tofu state list*)"
        "Bash(tofu state show*)"
        "Bash(tofu providers*)"
        "Bash(tofu workspace list*)"
        "Bash(tofu workspace show*)"
        "Bash(terragrunt init*)"
        "Bash(terragrunt plan*)"
        "Bash(terragrunt fmt*)"
        "Bash(terragrunt validate*)"
        "Bash(terragrunt show*)"
        "Bash(terragrunt output*)"
        "Bash(terragrunt state list*)"
        "Bash(terragrunt state show*)"
        "Bash(terragrunt graph-dependencies*)"
        "Bash(terragrunt hclfmt*)"
        "Bash(tflint *)"
        "Bash(tfsec *)"

        # Cloud CLIs (safe reads — delete/create/modify stay prompted)
        "Bash(gcloud config*)"
        "Bash(gcloud auth*)"
        "Bash(gcloud projects list*)"
        "Bash(gcloud compute instances list*)"
        "Bash(gcloud compute instances describe*)"
        "Bash(gcloud compute zones list*)"
        "Bash(gcloud compute regions list*)"
        "Bash(gcloud compute networks list*)"
        "Bash(gcloud compute firewall-rules list*)"
        "Bash(gcloud container clusters list*)"
        "Bash(gcloud container clusters describe*)"
        "Bash(gcloud iam service-accounts list*)"
        "Bash(gcloud iam roles list*)"
        "Bash(gcloud dns managed-zones list*)"
        "Bash(gcloud dns record-sets list*)"
        "Bash(gcloud sql instances list*)"
        "Bash(gcloud storage ls*)"
        "Bash(gcloud storage cat*)"
        "Bash(gcloud logging read*)"
        "Bash(gcloud services list*)"
        "Bash(gcloud info*)"
        "Bash(gsutil ls*)"
        "Bash(gsutil cat*)"
        "Bash(gsutil stat*)"
        "Bash(gsutil du*)"
        "Bash(bq ls*)"
        "Bash(bq show*)"
        "Bash(bq query*)"
        "Bash(bq head*)"
        "Bash(aws sts get-caller-identity*)"
        "Bash(aws configure list*)"
        "Bash(aws s3 ls*)"
        "Bash(aws s3 cp*)"
        "Bash(aws ec2 describe*)"
        "Bash(aws ecs describe*)"
        "Bash(aws ecs list*)"
        "Bash(aws eks describe*)"
        "Bash(aws eks list*)"
        "Bash(aws iam list*)"
        "Bash(aws iam get*)"
        "Bash(aws rds describe*)"
        "Bash(aws lambda list*)"
        "Bash(aws lambda get*)"
        "Bash(aws logs describe*)"
        "Bash(aws logs get*)"
        "Bash(aws logs filter*)"
        "Bash(aws cloudformation describe*)"
        "Bash(aws cloudformation list*)"
        "Bash(aws route53 list*)"
        "Bash(aws ssm get*)"
        "Bash(aws sts *)"
        "Bash(az account show*)"
        "Bash(az account list*)"
        "Bash(az group list*)"
        "Bash(az vm list*)"
        "Bash(az aks list*)"
        "Bash(az network *list*)"
        "Bash(az storage account list*)"

        # CI/CD & DevOps tools
        "Bash(gh *)"
        "Bash(act *)"
        "Bash(just *)"
        "Bash(mise *)"
        "Bash(make *)"
        "Bash(supabase *)"

        # Network & HTTP
        "Bash(curl *)"
        "Bash(wget *)"
        "Bash(nmap *)"
        "Bash(dig *)"
        "Bash(nslookup *)"
        "Bash(ping *)"
        "Bash(traceroute *)"
        "Bash(ssh *)"
        "Bash(scp *)"
        "Bash(rsync *)"
        "Bash(grpcurl *)"
        "Bash(telnet *)"

        # Go / Rust / Java / Hugo
        "Bash(go *)"
        "Bash(cargo *)"
        "Bash(rustup *)"
        "Bash(mvn *)"
        "Bash(gradle *)"
        "Bash(hugo *)"

        # Claude Code tools
        "WebSearch(*)"
        "WebFetch(*)"
        "Read(*)"
        "Write(*)"
        "Edit(*)"
        "Glob(*)"
        "Grep(*)"
        "Agent(*)"
      ];
      deny = [ ];
    };
    extraKnownMarketplaces = {
      everything-claude-code = {
        source = {
          source = "github";
          repo = "affaan-m/everything-claude-code";
        };
      };
    };
    enabledPlugins = {
      "everything-claude-code@everything-claude-code" = true;
    };
  };
  # /vm skill — invoke with `/vm` from any project
  vmSkill = ''
    ---
    description: Create, manage, and destroy VMs on Proxmox or OpenStack. Use when asked to spin up test VMs, create lab environments, or manage infrastructure.
    ---

    # VM Management Skill

    Parse the user's request to determine:
    1. **Platform**: Proxmox or OpenStack
    2. **Action**: create, destroy, list, ssh, status
    3. **OS**: which distro/version
    4. **Size**: resource requirements

    Default to **OpenStack** for quick disposable test VMs, **Proxmox** for desktop OS installs, multi-node clusters, or when the user specifies.

    ## Proxmox Cluster

    ### Access
    - **pve01**: 192.168.1.3 (SSH as root, key: ~/.ssh/id_ed25519)
    - **pve02**: 192.168.1.4 (SSH as root, key: ~/.ssh/id_ed25519)
    - **Storage**: `local` (ISOs), `local-lvm` (VM disks), `zfs-pool` (larger VMs)
    - **VMID range**: 110+ only (lower IDs are production)

    ### Pre-flight: check node load before creating
    ```bash
    ssh root@192.168.1.3 "pvesh get /nodes --output-format json-pretty | grep -E 'node|cpu|mem |maxmem|status'"
    ```

    ### Templates (always clone, never install from scratch)

    **Rocky Linux 10** — VMID 799 on pve02:
    ```bash
    # Clone on pve02 (fast)
    ssh root@192.168.1.4 "qm clone 799 <VMID> --name <name> --full true --storage local-lvm"
    ssh root@192.168.1.4 "qm set <VMID> --memory 4096 --cores 2 --ipconfig0 'ip=<IP>/24,gw=192.168.1.1' --nameserver 8.8.8.8"
    ssh root@192.168.1.4 "qm start <VMID>"
    ```
    SSH user: `rocky`

    To place on pve01 instead (clone on pve02, then migrate):
    ```bash
    ssh root@192.168.1.4 "qm clone 799 <VMID> --name <name> --full true --storage local-lvm"
    ssh root@192.168.1.4 "qm migrate <VMID> pve01"
    ssh root@192.168.1.3 "qm set <VMID> --memory 4096 --cores 2 --ipconfig0 'ip=<IP>/24,gw=192.168.1.1' --nameserver 8.8.8.8"
    ssh root@192.168.1.3 "qm start <VMID>"
    ```

    **Fedora 42** — VMID 800 on pve01:
    ```bash
    ssh root@192.168.1.3 "qm clone 800 <VMID> --name <name> --full true --storage local-lvm"
    ssh root@192.168.1.3 "qm set <VMID> --memory 4096 --cores 2 --ipconfig0 'ip=dhcp' --nameserver 8.8.8.8"
    ssh root@192.168.1.3 "qm resize <VMID> virtio0 30G"
    ssh root@192.168.1.3 "qm start <VMID>"
    ```
    SSH user: `root`. SELinux may block cloud-init SSH keys — if "Permission denied (publickey)", fix via disk mount (read c4geeks screenshots.md for the workaround).

    ### Desktop/ISO VMs (only when no template exists)
    ```bash
    # Check for existing ISOs first
    ssh root@192.168.1.3 "ls /var/lib/vz/template/iso/"
    ssh root@192.168.1.4 "ls /var/lib/vz/template/iso/"

    qm create <VMID> --name <name> --memory 8192 --cores 4 \
      --bios ovmf --efidisk0 local-lvm:1,efitype=4m,pre-enrolled-keys=0 \
      --machine q35 --scsihw virtio-scsi-single \
      --scsi0 local-lvm:60,iothread=1,discard=on \
      --ide2 local:iso/<iso>,media=cdrom --boot order='ide2;scsi0' \
      --net0 virtio,bridge=vmbr0 --vga virtio,memory=64 --ostype l26 --agent 1 --tablet 1
    ```

    ### VM Placement
    For multi-node clusters (Ceph, K8s, etc.), distribute VMs across both nodes.
    For 3-node setups: 2 on one host, 1 on the other.

    ### Proxmox CLI quick reference
    - List VMs: `pvesh get /nodes/<node>/qemu --output-format json-pretty`
    - VM status: `qm status <VMID>`
    - Stop + destroy: `qm stop <VMID> && qm destroy <VMID> --purge`
    - Screenshots: `qm monitor <VMID> <<< "screendump /tmp/name.ppm"`
    - Keyboard: `qm monitor <VMID> <<< 'sendkey ret'`

    ## OpenStack

    ### Access
    - **Config files** (read at runtime, never hardcode):
      - Terragrunt: `~/Library/Mobile Documents/com~apple~CloudDocs/projects/c4geeks/infra/terragrunt.hcl`
      - Images: `~/Library/Mobile Documents/com~apple~CloudDocs/projects/c4geeks/infra/images.json`
    - **Network**: `public` (44a581e7-9dd8-4802-94da-810f59127558)
    - **Keypair**: `jkmutai-mac`

    ### Quick launch (preferred)
    ```bash
    cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/projects/c4geeks/infra
    ./vm.sh launch ubuntu-24            # default: basic flavor
    ./vm.sh launch rocky-10 standard    # with more resources
    ./vm.sh launch debian-13 advanced
    ./vm.sh ssh                         # SSH into running VM
    ./vm.sh status                      # Current VM info
    ./vm.sh destroy                     # Clean up
    ./vm.sh list-os                     # Show all available images
    ```

    ### Available flavors
    | Name       | RAM   | Disk  | vCPUs |
    |------------|-------|-------|-------|
    | basic      | 2 GB  | 20 GB | 1     |
    | standard   | 4 GB  | 40 GB | 2     |
    | advanced   | 8 GB  | 80 GB | 2     |
    | business   | 16 GB | 160 GB| 4     |
    | enterprise | 32 GB | 240 GB| 8     |

    ### Direct OpenStack CLI
    When `vm.sh` isn't enough, read auth details from `terragrunt.hcl` and use `openstack` commands directly.

    ## Cleanup (MANDATORY)
    **Always destroy test VMs when done.** Never leave them running.
    - Proxmox: `qm stop <VMID> && qm destroy <VMID> --purge`
    - OpenStack: `./vm.sh destroy`
    - Verify no orphans: check `pvesh get /nodes/pve01/qemu` and `pvesh get /nodes/pve02/qemu`
  '';

  globalClaudeMd = ''
    # Global Instructions

    ## About me
    Senior DevOps/Platform engineer. Deep experience with Linux, Kubernetes, Terraform/OpenTofu,
    cloud (GCP, AWS), CI/CD, and nix-darwin. Don't explain basics — get to the point.

    ## Response style
    - Be concise. No summaries of what you just did — I can read the diff.
    - No "Great question!" or filler. Just answer.
    - When showing commands, show the command. Don't narrate what it does unless it's non-obvious.
    - Default to practical over theoretical.

    ## Preferred tools
    - **IaC**: `tofu` over `terraform`, `terragrunt` for multi-env
    - **Python**: `uv` over `pip`/`poetry` for new projects
    - **Containers**: `docker` primary, `podman` when rootless needed
    - **Shell**: zsh with eza/bat/fzf (aliased — `ls`=eza, `cat`=bat)
    - **K8s**: familiar with ArgoCD, Crossplane, Helm
    - **Editor**: Cursor, Antigravity (VS Code forks), Zed, NeoVim (nixvim)

    ## Key paths
    - **Projects root**: `~/Library/Mobile Documents/com~apple~CloudDocs/projects`
    - **Nix config**: `~/Library/Mobile Documents/com~apple~CloudDocs/projects/nixos-configs-mac`
    - **Rebuild alias**: `update` (runs darwin-rebuild switch)
    - **Upgrade alias**: `upgrade` (flake update + rebuild)

    ## Common hosts
    - **pve01**: 192.168.1.3 (Proxmox node 1, SSH root)
    - **pve02**: 192.168.1.4 (Proxmox node 2, SSH root)
    - **Web server**: 157.90.202.120 (computingforgeeks.com, SSH root)
    - SSH key: `~/.ssh/id_ed25519` for all

    ## Nix workflow
    - After editing any .nix file: `git add` the file, then `sudo darwin-rebuild switch --flake .`
    - New files MUST be tracked by git before rebuild (flakes require it)
    - System packages go in `modules/packages.nix`, per-program configs in `modules/home/programs/`

    ## Safety rules
    - Never commit `.env`, credentials, or secrets files
    - Never `git push --force` to main/master without asking
    - Never run `rm -rf` on home directory or project roots
    - Never hardcode credentials — read from env vars or config files at runtime
    - Always clean up test VMs/infrastructure when done
    - When working with cloud CLIs, prefer `--dry-run` or plan before apply/create
  '';
in
{
  home.file.".claude/settings.json".source =
    jsonFormat.generate "settings.json" claudeSettings;

  home.file.".claude/skills/vm/SKILL.md".text = vmSkill;
  home.file.".claude/CLAUDE.md".text = globalClaudeMd;
}
