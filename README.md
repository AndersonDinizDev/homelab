# Infraestrutura Homelab

[![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-844FBA?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Proxmox VE](https://img.shields.io/badge/Proxmox_VE-8.x-E57000?style=flat&logo=proxmox&logoColor=white)](https://www.proxmox.com/)
[![K3s](https://img.shields.io/badge/Kubernetes-K3s-FFC61C?style=flat&logo=k3s&logoColor=black)](https://k3s.io/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Debian](https://img.shields.io/badge/Debian-12%20%2F%2013-D70A53?style=flat&logo=debian&logoColor=white)](https://www.debian.org/)
[![Traefik](https://img.shields.io/badge/Traefik-Ingress-24A1C1?style=flat&logo=traefikproxy&logoColor=white)](https://traefik.io/)

Repositório responsável pelo gerenciamento e provisionamento automatizado da infraestrutura do meu Homelab, utilizando Terraform como solução de Infraestrutura como Código (IaC). A arquitetura é estruturada em duas camadas principais: a camada de virtualização, rede e segurança no Proxmox VE e a camada de orquestração de microsserviços no cluster Kubernetes (K3s).

---

## Índice

- [Visão Geral da Arquitetura](#visão-geral-da-arquitetura)
- [Estrutura do Repositório](#estrutura-do-repositório)
- [Camada de Infraestrutura (Proxmox VE)](#camada-de-infraestrutura-proxmox-ve)
  - [Topologia de Nós e Máquinas Virtuais](#topologia-de-nós-e-máquinas-virtuais)
  - [Containers LXC](#containers-lxc)
  - [Segurança e Firewall](#segurança-e-firewall)
  - [Endereçamento da Rede](#endereçamento-da-rede)
- [Camada de Aplicações (Kubernetes / K3s)](#camada-de-aplicações-kubernetes--k3s)
  - [Divisão de Namespaces e Serviços](#divisão-de-namespaces-e-serviços)
  - [Armazenamento Persistente (NFS)](#armazenamento-persistente-nfs)
  - [Roteamento e Ingress](#roteamento-e-ingress)
- [Gerenciamento de Estado Remoto (Backend S3)](#gerenciamento-de-estado-remoto-backend-s3)
- [Pré-requisitos](#pré-requisitos)
- [Como Utilizar](#como-utilizar)
  - [1. Provisionamento do Proxmox](#1-provisionamento-do-proxmox)
  - [2. Provisionamento do Kubernetes](#2-provisionamento-do-kubernetes)

---

## Visão Geral da Arquitetura

A infraestrutura foi projetada visando modularidade, isolamento de recursos, segurança em camadas e alta eficiência computacional:

1. **Virtualização e Rede Base (Proxmox VE)**:
   - Cluster Proxmox composto por dois nós físicos (`pve1` e `pve2`).
   - Provisionamento automatizado de Máquinas Virtuais (VMs) baseadas em Debian 13 (Trixie via Cloud-Init) e Containers de Sistema (LXC) em Debian 12.
   - Camada de firewall granular implementada no nível de cluster, nós, aliases de IP, ipsets e grupos de segurança dedicados.
   - Compartilhamento NFS centralizado no nó principal (`pve1`) para armazenamento persistente de dados e configurações.

2. **Orquestração de Containers (Kubernetes / K3s)**:
   - Cluster K3s distribuído entre nó Master (Control Plane) e nó Worker.
   - Separação lógica de serviços por namespaces dedicados (`media-center`, `work-center`, `backend-center`).
   - Ingress Controller baseado em Traefik integrado com proxy reverso e resolução de domínios customizados.
   - Volumes persistentes conectados via NFS com suporte ao modo de acesso compartilhado `ReadWriteMany` e subcaminhos (`subPath`) isolados por aplicação.

---

## Estrutura do Repositório

O projeto segue o padrão modular do Terraform, separando definições de módulos reutilizáveis e ambientes de execução (`prod`):

```text
.
├── kubernetes/
│   ├── environments/
│   │   └── prod/
│   │       ├── .kube/
│   │       │   └── k3s-config.yaml
│   │       ├── local.deployment.tf
│   │       ├── local.ingress.tf
│   │       ├── local.namespace.tf
│   │       ├── local.persistent_volume.tf
│   │       ├── local.persistent_volume_claim.tf
│   │       ├── local.service.tf
│   │       ├── main.tf
│   │       ├── output.tf
│   │       ├── terraform.tfvars
│   │       └── variables.tf
│   └── modules/
│       ├── deployment/
│       ├── ingress/
│       ├── namespace/
│       ├── persistent_volume/
│       ├── persistent_volume_claim/
│       └── service/
├── proxmox/
│   ├── environments/
│   │   └── prod/
│   │       ├── local.container.tf
│   │       ├── local.firewall.alias.tf
│   │       ├── local.firewall.ipset.tf
│   │       ├── local.firewall.options.tf
│   │       ├── local.firewall.rule.tf
│   │       ├── local.firewall.security.group.tf
│   │       ├── local.vm.tf
│   │       ├── main.tf
│   │       ├── terraform.tfvars
│   │       └── variables.tf
│   └── modules/
│       ├── firewall_alias/
│       ├── firewall_ipset/
│       ├── firewall_options/
│       ├── firewall_rule/
│       ├── firewall_security_group/
│       ├── proxmox_lxc/
│       └── proxmox_vm/
└── README.md
```

---

## Camada de Infraestrutura (Proxmox VE)

Gerenciada via Terraform através do provedor oficial `bpg/proxmox`.

### Topologia de Nós e Máquinas Virtuais

| ID da VM | Nome do Host | Nó Proxmox | Endereço IP | vCPU | Memória RAM | Disco | Sistema Operacional | Função / Papel |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `102` | `k3s-master` | `pve1` | `192.168.100.13` | 2 núcleos | 4 GB | 32 GB (SCSI) | Debian 13 (Cloud-Init) | Nó Control Plane (Master) do K3s |
| `103` | `k3s-worker-1` | `pve2` | `192.168.100.33` | 2 núcleos | 4 GB | 32 GB (SCSI) | Debian 13 (Cloud-Init) | Nó de Execução de Cargas (Worker) do K3s |

### Containers LXC

| ID do CT | Nome do Host | Nó Proxmox | Endereço IP | Memória RAM | Disco | Template Base | Modo de Isolamento | Função / Papel |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `100` | `container-registry` | `pve2` | `192.168.100.34` | 2 GB | 30 GB + 100 GB (mount OCI) | Debian 12 Padrão | Não privilegiado (Nesting ativo) | Registro local de imagens de containers, exposto na porta TCP `5000` apenas para o proxy reverso |

O container `100` monta o volume `nt-storage-pve:100/vm-100-disk-0.raw` em `/mnt/nt-storage` para armazenar as camadas das imagens, ficando fora do backup padrão do Proxmox.

### Segurança e Firewall

A infraestrutura adota o princípio de menor privilégio com filtragem de pacotes e isolamento de rede:
- **Aliases de Rede**: Mapeamento centralizado de endereços IP para Gateway, Nós Proxmox, Estações de Administração, Proxy Reverso (Caddy), VMs e Containers.
- **IPSets**: Agrupamento dinâmico de nós do cluster (`cluster_nodes`) e nós de trabalho (`workers_nodes`).
- **Grupos de Segurança**:
  - `default-sg`: Libera acesso administrativo via SSH (porta 22) restrito a endereços IPs confiáveis.
  - `k3s-sg-master`: Permite a comunicação de entrada vinda do proxy reverso e do nó worker para o Control Plane.
  - `k3s-sg-worker`: Permite a comunicação de entrada vinda do proxy reverso e do nó master, além das portas de transferências P2P/BitTorrent (TCP/UDP 6881).
- **Regras Globais e Políticas de Entrada**: Política padrão de entrada `DROP` com liberações explícitas para tráfego NFS (porta 2049 TCP/UDP), API Proxmox (porta 8006, liberada para o proxy reverso), Kubernetes API (porta 6443, liberada apenas para o notebook de administração), registro de containers (porta 5000, liberada para o proxy reverso) e tráfego interno do cluster.

### Endereçamento da Rede

Todos os endereços são gerenciados como aliases de firewall no Terraform, evitando IPs soltos nas regras:

| Alias | Endereço | Papel |
| :--- | :--- | :--- |
| `gateway` | `192.168.100.1` | Gateway da rede e host do proxy reverso (Caddy) |
| `pve_1` | `192.168.100.11` | Nó Proxmox principal, servidor NFS e endpoint da API |
| `pve_2` | `192.168.100.31` | Nó Proxmox secundário e host do registro de containers |
| `k3s_master` | `192.168.100.13` | VM `k3s-master` (Control Plane) |
| `k3s_worker_1` | `192.168.100.33` | VM `k3s-worker-1` (Worker) |
| `container_registry` | `192.168.100.34` | LXC com o registro local de imagens |
| `my_notebook` | `192.168.100.101` | Estação de administração (SSH e `kubectl`) |
| `my_phone` | `192.168.100.102` | Dispositivo móvel |

---

## Camada de Aplicações (Kubernetes / K3s)

Gerenciada via Terraform através do provedor `hashicorp/kubernetes`.

### Divisão de Namespaces e Serviços

| Namespace | Serviço / Aplicação | Imagem / Stack | Descrição e Finalidade |
| :--- | :--- | :--- | :--- |
| `media-center` | **Jellyfin** | `jellyfin/jellyfin:latest` | Servidor de streaming e reprodução de mídia |
| `media-center` | **qBittorrent** | `linuxserver/qbittorrent` | Cliente de download e distribuição de arquivos BitTorrent |
| `media-center` | **Radarr** | `linuxserver/radarr` | Gerenciador e automatizador de downloads de filmes |
| `media-center` | **Sonarr** | `linuxserver/sonarr` | Gerenciador e automatizador de downloads de séries |
| `media-center` | **Seerr** | `seerr/seerr` | Gerenciador unificado de descoberta e solicitação de mídia |
| `media-center` | **Prowlarr** | `linuxserver/prowlarr` | Gerenciador integrado de indexadores e integração com Radarr/Sonarr |
| `work-center` | **Vaultwarden** | `vaultwarden/server` | Gerenciador de senhas e credenciais compatível com Bitwarden |
| `work-center` | **Trilium Notes** | `triliumnext/trilium` | Base de conhecimento pessoal e anotações estruturadas |
| `work-center` | **n8n** | `n8nio/n8n:latest` | Plataforma de automação de workflows e integrações |
| `backend-center` | **PostgreSQL** | `pgvector/pgvector:pg18` | Banco de dados relacional (com extensão `pgvector`), base `homelab`; o n8n usa o schema dedicado `n8n` |
| `backend-center` | **Gotify** | `gotify/server:latest` | Servidor de notificações push para alertas da infraestrutura |

### Armazenamento Persistente (NFS)

O cluster utiliza Persistent Volumes (PV) e Persistent Volume Claims (PVC) integrados ao mesmo export NFS do nó `pve1` (`192.168.100.11:/storage-pve/proxmox`), com um conjunto de volumes por namespace:

| Persistent Volume | Capacidade | PVC (namespace) | Capacidade solicitada | Uso |
| :--- | :--- | :--- | :--- | :--- |
| `nt-storage` | 500 Gi | `nt-storage` (`media-center`) | 100 Gi | Configurações e biblioteca do Jellyfin, qBittorrent, Radarr, Sonarr, Prowlarr e Seerr |
| `nt-storage-2` | 100 Gi | `nt-storage-2` (`work-center`) | 50 Gi | Vaultwarden, Trilium e n8n |
| `nt-storage-3` | 100 Gi | `nt-storage-3` (`backend-center`) | 50 Gi | PostgreSQL e Gotify |

- **Modo de Acesso**: `ReadWriteMany` (RWX), possibilitando que múltiplos pods em diferentes nós leiam e gravem no mesmo volume simultaneamente.
- **Isolamento de Diretórios**: Utilização de `subPath` para segregação de arquivos de configuração (`/config`) e bibliotecas de dados (`/data`).

### Roteamento e Ingress

As aplicações são publicadas externamente através de regras de Ingress gerenciadas pelo Traefik com suporte a domínios personalizados:

| Domínio de Acesso | Serviço de Destino (porta do Service) | Porta do container | Namespace |
| :--- | :--- | :--- | :--- |
| `streaming.andersondiniz.com` | `jellyfin-service:8096` | `8096` | `media-center` |
| `qbittorrent.andersondiniz.com` | `qbittorrent-service:8080` | `8080` | `media-center` |
| `radarr.andersondiniz.com` | `radarr-service:7878` | `7878` | `media-center` |
| `prowlarr.andersondiniz.com` | `prowlarr-service:9696` | `9696` | `media-center` |
| `sonarr.andersondiniz.com` | `sonarr-service:8989` | `8989` | `media-center` |
| `seerr.andersondiniz.com` | `seerr-service:8534` | `5055` | `media-center` |
| `vault.andersondiniz.com` | `vaultwarden-service:8972` | `80` | `work-center` |
| `notes.andersondiniz.com` | `triliumnotes-service:8862` | `8080` | `work-center` |
| `n8n.andersondiniz.com` | `n8n-service:8532` | `5678` | `work-center` |
| `message.andersondiniz.com` | `gotify-service:8831` | `80` | `backend-center` |

Os Services usam portas próprias (por exemplo `8972` para o Vaultwarden e `8532` para o n8n) apenas para evitar conflito entre namespaces; quem escuta dentro do container continua sendo a porta nativa da aplicação. O acesso externo passa primeiro pelo proxy reverso (Caddy) no gateway e chega ao Ingress Controller Traefik (`ingressClassName: traefik`).

---

## Gerenciamento de Estado Remoto (Backend S3)

O estado das execuções do Terraform (`tfstate`) é mantido em armazenamento remoto e seguro no Amazon S3 com criptografia e trava de concorrência:
- **Bucket**: `homelab-259553642804-us-east-1-an`
- **Região**: `us-east-1`
- **Criptografia**: `encrypt = true` no bloco de backend
- **Trava de Concorrência**: `use_lockfile = true`, que usa o lock nativo do S3 (dispensa tabela DynamoDB)
- **Caminho das Chaves de Estado**:
  - Infraestrutura Proxmox: `infra/prod/terraform.tfstate`
  - Aplicações Kubernetes: `kubernetes/prod/terraform.tfstate`

---

## Pré-requisitos

Para executar e gerenciar a infraestrutura, certifique-se de possuir:

1. **Ferramentas de Linha de Comando (CLI)**:
   - `terraform` (versão >= 1.5.0)
   - `kubectl` (para interação direta com o cluster K3s)
   - `aws-cli` (configurado com credenciais para acesso ao bucket S3 de backend)

2. **Acessos e Credenciais**:
   - Token de API com permissões adequadas no Proxmox VE.
   - Par de chaves SSH para injeção via Cloud-Init nas VMs e LXC.
   - Arquivo de configuração de acesso ao K3s posicionado em `kubernetes/environments/prod/.kube/k3s-config.yaml`.

3. **Provedores do Terraform** (versões fixadas no `.terraform.lock.hcl`):
   - `bpg/proxmox` `0.111.0`
   - `hashicorp/kubernetes` `3.0.1`
   - `hashicorp/local` `2.9.0`

---

## Como Utilizar

### 1. Provisionamento do Proxmox

Navegue até o diretório do ambiente de produção do Proxmox:

```bash
cd proxmox/environments/prod
```

Configure as variáveis de ambiente ou crie um arquivo `terraform.tfvars`:

```hcl
endpoint      = "https://192.168.100.11:8006/"
api_token     = "usuario@pve!token=seu-token-aqui"
user_password = "senha-root-temporaria"
ssh_key       = "~/.ssh/id_rsa.pub"
```

Inicialize o Terraform, valide o plano de execução e aplique as configurações:

```bash
terraform init
terraform plan
terraform apply
```

### 2. Provisionamento do Kubernetes

Com as VMs do cluster K3s ativas e o arquivo de autenticação posicionado em `kubernetes/environments/prod/.kube/k3s-config.yaml`, navegue até o diretório:

```bash
cd ../../../kubernetes/environments/prod
```

Configure o arquivo `terraform.tfvars` com os parâmetros do banco de dados e as credenciais do usuário dedicado do n8n:

```hcl
postgres_root_password  = "senha-postgres-root"
postgres_n8n_user       = "n8n"
postgres_n8n_password   = "senha-do-usuario-n8n"
```

O n8n se conecta ao Service `postgresql-service.backend-center` na porta `5432`, usando a base `homelab` e o schema `n8n`.

Inicialize o backend remoto e provisione as aplicações no cluster:

```bash
terraform init
terraform plan
terraform apply
```
